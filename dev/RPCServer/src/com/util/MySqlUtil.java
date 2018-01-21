/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import java.lang.reflect.Method;
import java.net.SocketException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.model.Column;
import com.model.Model;
import com.model.Table;
import com.statics.Config;

/**
 *  数据库操作
 */
public class MySqlUtil {
    private static boolean showLog = true;
    
	private static List<Connection> jdbcConnectionList = new ArrayList<Connection>();//当前可用连接
	private static int currActiveCount = 0;//当前活跃数量
	
	//保存常用的SQL语句,使用的时候取出来立刻用
	private static final Map<String, String> SQL_CLASS_INSERT = new HashMap<String, String>();
	private static final Map<String, String> SQL_CLASS_UPDATE = new HashMap<String, String>();
	private static final Map<String, String> SQL_CLASS_DELETE = new HashMap<String, String>();
	//保存常用的方法对象,使用的时候取出来立刻用
	private static final Map<String, List<Method>> SQL_CLASS_METHOD_ALL = new HashMap<String, List<Method>>();
	private static final Map<String, List<Method>> SQL_CLASS_METHOD_INSERT = new HashMap<String, List<Method>>();
	private static final Map<String, List<Method>> SQL_CLASS_METHOD_SET = new HashMap<String, List<Method>>();
	private static final Map<String, List<Method>> SQL_CLASS_METHOD_WHERE = new HashMap<String, List<Method>>();
	
	//需要用的sql语句
	private static final String SQL_CREATE_TABLE = "CREATE TABLE `%s` (%s) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;";
	private static final String SQL_CREATE_COLUMN = "`%s` %s(%s) NOT NULL,";
	private static final String SQL_CREATE_COLUMN_NO_LENGTH = "`%s` %s NOT NULL,";
	private static final String SQL_CREATE_COLUMN_AUTO = "`%s` %s(%s) NOT NULL AUTO_INCREMENT,";
	private static final String SQL_CREATE_COLUMN_KEY = "PRIMARY KEY (%s),";
	private static final String SQL_CREATE_COLUMN_NAME = "`%s`,";
	private static final String SQL_ALTER_ADD = "alter table `%s` add `%s` %s(%s);";
	private static final String SQL_ALTER_ADD2 = "alter table `%s` add `%s` %s;";
	private static final String SQL_ALTER_DROP = "alter table `%s` drop `%s`;";
	private static final String SQL_ALTER_MODIFY = "alter table `%s` modify `%s` %s(%s);";
	private static final String SQL_ALTER_MODIFY2 = "alter table `%s` modify `%s` %s;";
	private static final String SQL_SELECT_ALL = "select * from `%s`";
	private static final String SQL_SELECT_WHERE = SQL_SELECT_ALL+" where %s";

	/**
	 * 初始化JDBC
	 * @throws Exception 
	 */
	public static void initJDBC() throws Exception {
		//创建连接
		for (int i = 0; i < Config.JDBC_INIT_ACTIVE * 2; i++) {
			createConnection();
		}
		//检查表结构
		checkTableColumn();
		//启动定时器,保持数据库连接
		timeoutThread();
	}

	private static void timeoutThread() {
		new Thread(new Runnable() {
			public void run() {
				long t = 1 * 60 * 60 * 1000;
				String sql = "select 1;";
				while(true){
					try {
						Thread.sleep(t);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					try {
						int die = 0;
						synchronized (jdbcConnectionList) {
							for (int i = jdbcConnectionList.size()-1;i >= 0; i--) {
								Connection conn = jdbcConnectionList.get(i);
								if(null == conn || conn.isClosed()){
									currActiveCount--;
									jdbcConnectionList.remove(i);
									die++;
									continue;
								}
								try {
									Statement statement = conn.createStatement();
									statement.executeUpdate(sql);
									statement.close();
									statement = null;
								} catch (Exception e) {
									currActiveCount--;
									jdbcConnectionList.remove(i);
									die++;
								}
							}
						}
						System.out.println("MySqlUtil timeoutThread die count : "+die);
					} catch (Exception e) {
						System.out.println("MySqlUtil timeoutThread error,"+e.getLocalizedMessage());
						e.printStackTrace();
					}
				}
			}
		}).start();
	}

	/**
	 * 创建连接
	 */
	private static void createConnection() throws Exception {
		try {
			Class.forName(Config.JDBC_DRIVER);
			Connection connection = DriverManager.getConnection(Config.JDBC_URL, Config.JDBC_USERNAME,
							Config.JDBC_PASSWORD);
			if (connection.isClosed()) {
				System.out.println("JdbcUtil createConnection error,isClosed");
			}
			jdbcConnectionList.add(connection);
			currActiveCount++;
			System.out.println("JdbcUtil createConnection Active Count : "+ currActiveCount);
		} catch (ClassNotFoundException e) {
			System.out.println("JdbcUtil createConnection error"+ e.getLocalizedMessage());
			throw e;
		} catch (SQLException e) {
			System.out.println("JdbcUtil createConnection error"+ e.getLocalizedMessage());
			throw e;
		}
	}
	
	/**
	 * 获取一个连接
	 * @return
	 * @throws Exception 
	 * @throws SQLException 
	 */
	private static synchronized Connection getConnection() throws Exception{
		if(jdbcConnectionList.isEmpty()){			
			//每次创建2个可用连接
			for(int i = 0;i < 2;i++){
				createConnection();
			}
			if(jdbcConnectionList.isEmpty())return null;
		}
		//取出第一个连接
		Connection connection = jdbcConnectionList.remove(0);
		try {
			for(int i = 0;i < 10;i++){
				//取10次,都是关闭的,那么就不取数据了
				if(connection.isClosed() == false){
					return connection;
				}
				//如果连接已经关闭了,抛弃,并且重新取一个
				try {
					connection.close();
					connection = null;
					currActiveCount-- ;
				} catch (Exception e) {
				}
				if(jdbcConnectionList.isEmpty()){
					createConnection();
				}
				connection = jdbcConnectionList.remove(0);
			}
			return connection;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * 关闭一个连接
	 * @param connection
	 */
	private static void closeConnection(Connection connection) {
		if(null == connection)return;
		try {
			currActiveCount--;
			connection.close();
			connection = null;
		} catch (Exception e) {
		}
	}
	/**
	 * 保存一个连接
	 * @param connection
	 * @throws SQLException 
	 */
	private static synchronized void saveConnection(Connection connection){
		if(null == connection)return;
		jdbcConnectionList.add(connection);
	}
	/**
	 * 检查表结构
	 * @throws Exception 
	 */
	private static void checkTableColumn() throws Exception {
		//取出所有表
		List<String> list = getListBySql("show tables;", String.class);
		
		Package packages = Model.class.getPackage();
		Set<Class<?>> classes = ClassUtil.getClasses(packages);
		for (Class<?> clazz : classes) {
			Table table = clazz.getAnnotation(Table.class);
			if(null == table)continue;
			try {
				String tableName = table.name();
				String newTableName = String.format("%s",tableName);
				if(list.contains(newTableName) == false){
					//创建表
					createTable(clazz,newTableName);
				}
				//检查字段
				checkColumn(clazz,newTableName);
			} catch (Exception e) {
				System.out.println("JdbcUtil checkTableColumn error,"+clazz.getName()+","+e.getLocalizedMessage());
				e.printStackTrace();
			}
		}
	}
	/**
	 * 检查字段
	 * @param clazz 需要检查的类
	 * @param tableName 表名
	 * @throws Exception 
	 */
	private static void checkColumn(Class<?> clazz, String tableName) throws Exception {
		List<String[]> list = getListBySql("desc "+tableName+";", String[].class);
		//表里面的所有字段<name,类型>["uid","varchar(255)"]
		Map<String,String> fieldAll = new HashMap<String,String>();
		for (String[] strings : list) {
			fieldAll.put(strings[0], strings[1]);
		}
		StringBuilder fieldNameSB = new StringBuilder();
		StringBuilder fieldValueSB = new StringBuilder();
		StringBuilder setSB = new StringBuilder();
		StringBuilder whereSB = new StringBuilder();
		List<Method> method_insert = new ArrayList<Method>();
		List<Method> method_where = new ArrayList<Method>();
		List<Method> method_set = new ArrayList<Method>();
		List<String> sqlList = new ArrayList<String>();
		
		List<Method> methods = getClassMethods(clazz);
		for (Method method : methods) {
			Column column = method.getAnnotation(Column.class);
			String[] methodColumn = getMethodColumn(method, column);
			fieldNameSB.append(String.format("`%s`,", methodColumn[0]));
			fieldValueSB.append("'%s',");
			
			//取出来
			String tempType = fieldAll.remove(methodColumn[0]);
			if(null == tempType){
				//如果字段不存在
				if(null == methodColumn[2]){
					String sql = String.format(SQL_ALTER_ADD2,tableName,methodColumn[0],methodColumn[1]);
					sqlList.add(sql);
				}else{
					String sql = String.format(SQL_ALTER_ADD,tableName,methodColumn[0],methodColumn[1],methodColumn[2]);
					sqlList.add(sql);
				}
			}else{
				String str = String.format("%s(%s)", methodColumn[1],methodColumn[2]);
				if("text".equals(tempType) ||
						"datetime".equals(tempType) ||
						"longtext".equals(tempType)){//text类型没有长度
					str = String.format("%s", methodColumn[1]);
				}
				//特殊类型不进行判断
				boolean check = true;
				if("text".equals(tempType) && "longtext".equals(str)){
					check = false;
				}
				if("text".equals(str) && "longtext".equals(tempType)){
					check = false;
				}
				//类型或者长度不一样
				if(check && tempType.equals(str)==false){
					if(null == methodColumn[2]){
						String sql = String.format(SQL_ALTER_MODIFY2,tableName,methodColumn[0],methodColumn[1]);
						sqlList.add(sql);
					}else{
						String sql = String.format(SQL_ALTER_MODIFY,tableName,methodColumn[0],methodColumn[1],methodColumn[2]);
						sqlList.add(sql);
					}
				}
			}
			if(column != null && column.id()){
				method_where.add(method);
				whereSB.append(String.format(" `%s`=", methodColumn[0]));
				whereSB.append("'%s' and");
			}else{
				method_set.add(method);
				setSB.append(String.format(" `%s`=", methodColumn[0]));
				setSB.append("'%s',");
				method_insert.add(method);
			}
		}
		//剩下的都删除
		for(String columnName : fieldAll.keySet()){
			String sql = String.format(SQL_ALTER_DROP,tableName,columnName);
			executeSql(sql);
		}
		//先处理删除的字段，最后处理增加和修改
		for(String sql : sqlList){
			executeSql(sql);
		}
		fieldNameSB.setLength(fieldNameSB.length()-1);
		fieldValueSB.setLength(fieldValueSB.length()-1);
		String sql = String.format("insert into `%s` (%s) values (%s);", tableName,fieldNameSB.toString(),fieldValueSB.toString());
		//去掉id
		if(sql.contains(",`id`")){
			sql = sql.replaceFirst(",`id`", "").replaceFirst(",'%s'", "");
		}else if(sql.contains("`id`,")){
			sql = sql.replaceFirst("`id`,", "").replaceFirst(",'%s'", "");
		}
		logdebug(sql);
		if(setSB.length() > 1){
			setSB.setLength(setSB.length()-1);
		}
		whereSB.setLength(whereSB.length()-3);
		String sql_update = String.format("update `%s` set %s where %s;", tableName,setSB.toString(),whereSB.toString());
		logdebug(sql_update);
		String sql_delete = String.format("delete from `%s` where %s;", tableName,whereSB.toString());
		logdebug(sql_delete);
		
		SQL_CLASS_INSERT.put(tableName, sql);
		SQL_CLASS_UPDATE.put(tableName, sql_update);
		SQL_CLASS_DELETE.put(tableName, sql_delete);
		SQL_CLASS_METHOD_INSERT.put(tableName, method_insert);
		SQL_CLASS_METHOD_WHERE.put(tableName, method_where);
		SQL_CLASS_METHOD_SET.put(tableName, method_set);
	}

	private static void logdebug(String sql) {
		log(sql);		
	}

	/**
	 * 创建表
	 * @param clazz
	 * 		对象类
	 * @param tableName
	 * 		表名 
	 * @throws Exception 
	 */
	private static void createTable(Class<?> clazz, String tableName) throws Exception {
		StringBuilder columnSB = new StringBuilder();
		StringBuilder keySB = new StringBuilder();
		List<Method> methods = getClassMethods(clazz);
		for (Method method : methods) {
			Column column = method.getAnnotation(Column.class);
			String[] methodColumn = getMethodColumn(method, column);
			if(null != column && column.id()){
				//如果是主键
				keySB.append(String.format(SQL_CREATE_COLUMN_NAME, methodColumn[0]));
				String sql = String.format(SQL_CREATE_COLUMN_AUTO, methodColumn[0],methodColumn[1],methodColumn[2]);
				columnSB.append(sql);
			}else if(methodColumn[2] == null){
				String sql = String.format(SQL_CREATE_COLUMN_NO_LENGTH, methodColumn[0],methodColumn[1]);
				columnSB.append(sql);
			}else{
				String sql = String.format(SQL_CREATE_COLUMN, methodColumn[0],methodColumn[1],methodColumn[2]);
				columnSB.append(sql);
			}
		}
		if(keySB.length() > 0){
			keySB.setLength(keySB.length()-1);
			String key = String.format(SQL_CREATE_COLUMN_KEY, keySB.toString());
			columnSB.append(key);
		}
		columnSB.setLength(columnSB.length()-1);
		
		String sql = String.format(SQL_CREATE_TABLE, tableName,columnSB.toString());
		executeSql(sql);
	}
	/**
	 * 获取class的属性列表
	 * @param clazz
	 * @return
	 */
	private static List<Method> getClassMethods(Class<?> clazz){
		List<Method> list = SQL_CLASS_METHOD_ALL.get(clazz.getSimpleName());
		if(null != list){
			return list;
		}
		List<Method> methods = new ArrayList<Method>();
		for(Method method : clazz.getDeclaredMethods()){
			Column column = method.getAnnotation(Column.class);
			if(null != column && column.temp()){
				continue;//跳过临时的
			}
			if(method.getName().startsWith("set")){
				continue;//跳过set方法
			}
			methods.add(method);
		}
		Class<?> superclass = clazz.getSuperclass();
		if(null != superclass && "Object".equals(superclass.getSimpleName()) == false){
			methods.addAll(getClassMethods(superclass));
		}
		return methods;
	}
	/**
	 * 获取属性字段对应的数据库字段数据
	 * @param method
	 * 		方法
	 * @param column
	 * 		字段
	 * @return [0=字段名;1=字段类型;2=字段长度]
	 */
	private static String[] getMethodColumn(Method method, Column column) {
		String columnName = method.getName();
		if(columnName.startsWith("get")){
			columnName = columnName.substring(3,columnName.length());
		}else if(columnName.startsWith("is")){
			columnName = columnName.substring(2,columnName.length());
		}
		char nameFirst = columnName.charAt(0);//首字母转小写
		columnName = String.valueOf(nameFirst).toLowerCase()+columnName.substring(1,columnName.length());
		String columnType = null;
		String columnLength = null;
		if(int.class.equals(method.getReturnType()) 
				|| Integer.class.equals(method.getReturnType())){
			columnType = "int";
			columnLength = "11";
		}else if(String.class.equals(method.getReturnType())){
			columnType = "varchar";
			columnLength = "255";
		}else if(boolean.class.equals(method.getReturnType())
				|| Boolean.class.equals(method.getReturnType())){
			columnType = "smallint";
			columnLength = "1";
		}else if(Long.class.equals(method.getReturnType()) 
				|| long.class.equals(method.getReturnType())){
			columnType = "bigint";
			columnLength = "20";
		}else if(double.class.equals(method.getReturnType())
				|| Double.class.equals(method.getReturnType())){
			columnType = "double";
			columnLength = "11,2";
		}else if(Date.class.equals(method.getReturnType())){
			columnType = "datetime";
			columnLength = null;
		}
		if(null != column){
			if(!column.name().isEmpty()){
				columnName = column.name();
			}
			if(!column.type().isEmpty()){
				columnType = column.type();
			}
			if("longtext".equals(columnType) 
					|| "text".equals(columnType)
					|| "datetime".equals(columnType)){
				columnLength = null;
			}else{
				if(column.length() != 0){
					if("double".equals(columnType)){
						columnLength = column.length()+",2";
					}else{
						columnLength = String.valueOf(column.length());
					}
				}
			}
		}
		return new String[]{columnName,columnType,columnLength};
	}
	/**
	 * 根据方法,获取方法内的值
	 * @param model
	 * @param methodList
	 * @return
	 * @throws Exception
	 */
	private static <T extends Model> Object[] getValueByMethod(T model,List<Method> methodList) throws Exception {
		int size = methodList.size();
		Object[] objs = new Object[size];
		for (int i=0;i<size;i++) {
			Method method = methodList.get(i);
			Object obj = method.invoke(model);
			if(null == obj){
				if(Integer.class.equals(method.getReturnType()) 
						|| Long.class.equals(method.getReturnType()) 
						|| Double.class.equals(method.getReturnType()) 
						|| Boolean.class.equals(method.getReturnType())){
					obj = 0;
				}else if(Date.class.equals(method.getReturnType())){
					obj = DateUtil.format.format(new Date());
				}else{
					obj = "";
				}
			}else if(Date.class.equals(method.getReturnType())){
				obj = DateUtil.format.format(obj);
			}else if(Boolean.class.equals(method.getReturnType()) 
					|| boolean.class.equals(method.getReturnType())){
				obj = ((Boolean)obj == true ? 1 : 0);
			}
			objs[i] = obj;
		}
		return objs;
	}
	/**
	 * 执行sql语句(未分服,需要在TableNmae中增加服务器ID)
	 * @param sql
	 * 		SQL语句
	 * @throws Exception 
	 */
	public static int executeSql(String sql,Object...params) throws Exception {
		logdebug("JdbcUtil executeSql : "+sql);
		Connection connection = null;
		try {
			connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			setPrepareStatementParams(statement,params);
			int rs = statement.executeUpdate();
			statement.close();
			statement = null;
			return rs;
		} catch (SocketException e) {
			closeConnection(connection);
			throw e;
		} catch (Exception e) {
			throw e;
		}finally{
			saveConnection(connection);
		}
	}

	private static void setPrepareStatementParams(PreparedStatement prepareStatement,Object...params) throws SQLException {
		if(params != null){
			for (int i = 0; i < params.length; i++) {
				Object o = params[i];
				if(o instanceof Integer){
					prepareStatement.setInt(i+1, (int) o);
				}else if(o instanceof Long){
					prepareStatement.setLong(i+1, (long) o);
				}else if(o instanceof Float){
					prepareStatement.setFloat(i+1, (float) o);
				}else{
					prepareStatement.setString(i+1, o.toString());
				}
			}
		}		
	}

	/**
	 * 查询数据
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	public static <T extends Model> List<T> getList(Class<T> clazz) throws Exception{
		Table table = clazz.getAnnotation(Table.class);
		if(null == table)throw new Exception(clazz.getName()+" not is Table !!!");
		String tableName = table.name();
		String sql = String.format(SQL_SELECT_ALL, tableName);
		return getListBySql(sql,clazz);
	}
	/**
	 * 查询数据库
	 * @param sql
	 * 		sql语句
	 * @param clazz
	 * 		返回对应的类
	 * @param params 
	 * @return 返回List数组
	 */
	public static <T> List<T> getListBySql(String sql,Class<T> clazz, Object... params) throws Exception {
		logdebug("JdbcUtil getList : "+sql);
		List<T> list = new ArrayList<T>();
		Connection connection = null;
		try {
			connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			setPrepareStatementParams(statement,params);
			ResultSet rs = statement.executeQuery();
			Set<String> set = new HashSet<String>();
			while(rs.next()){
				list.add(getColumnValue(rs,clazz,set));
			}
			rs.close();
			rs = null;
			statement.close();
			statement = null;
		} catch (SocketException e) {
			closeConnection(connection);
			throw e;
		} catch (Exception e) {
			throw e;
		}finally{
			saveConnection(connection);
		}
		return list;
	}
	public static <T> List<T> getListBySql(Class<T> clazz,String sql,Object...params) throws Exception {
		return getListBySql(sql, clazz, params);
	}
	
	/**
	 * 查询数据
	 * @param id
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	public static <T extends Model> T getOneById(int id,Class<T> clazz) throws Exception{
		if(id <= 0)return null;
		Table table = clazz.getAnnotation(Table.class);
		if(null == table)throw new Exception(clazz.getName()+" not is Table !!!");
		String tableName = table.name();
		StringBuilder whereSB = new StringBuilder();
		whereSB.append(String.format("`id`='%d' limit 1",id));
		String sql = String.format(SQL_SELECT_WHERE,tableName,whereSB.toString());
		List<T> list = getListBySql(sql,clazz);
		if(list == null ||list.isEmpty()){
			return null;
		}
		return list.get(0);
	}
	public static <T> T getOneBySql(String sql,Class<T> clazz,Object...params) throws Exception {
		List<T> listBySql = getListBySql(sql, clazz,params);
		if(null == listBySql || listBySql.isEmpty())return null;
		return listBySql.get(0);
	}
	public static <T> T getOneBySql(Class<T> clazz,String sql,Object...params) throws Exception {
		return getOneBySql(sql, clazz,params);
	}
	
	@SuppressWarnings("unchecked")
	private static <T> T getColumnValue(ResultSet rs,Class<T> clazz,Set<String> set) throws Exception {
		T t = null;
		Table table = clazz.getAnnotation(Table.class);
		if(null != table){//是表结构
			t = clazz.newInstance();
			
			List<Method> methods = getClassMethods(clazz);
			for (Method method : methods) {
				try {
					Column column = method.getAnnotation(Column.class);
					String[] methodColumn = getMethodColumn(method, column);
					if(set.contains(methodColumn[0]))continue;
					int col = -1;
					try {  
						col = rs.findColumn(methodColumn[0]);
					}catch (SQLException e) {
						col = -1;
					}
					if(col < 0){
						set.add(methodColumn[0]);
						continue;
					}
					Object obj = rs.getObject(col);
					
					obj = getColumnValueImpl(obj,method.getReturnType());
					
					String methodName = getMethodName(methodColumn[0],"set");
					Method setMethod = clazz.getMethod(methodName,method.getReturnType());
					setMethod.invoke(t, obj);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}else{
			if(clazz.equals(Object[].class)
					|| clazz.equals(String[].class)
					|| clazz.equals(int[].class)
					|| clazz.equals(Integer[].class)){
				//数组结构
				ResultSetMetaData metaData = rs.getMetaData();
				Object[] obj = null;
				Class<?> tempClazz = null;
				if(clazz.equals(Object[].class)){
					tempClazz = Object.class;
					obj = new Object[metaData.getColumnCount()];
				}else if(clazz.equals(String[].class)){
					obj = new String[metaData.getColumnCount()];
					tempClazz = String.class;
				}else if(clazz.equals(Integer[].class)
						|| clazz.equals(int[].class)){
					obj = new Integer[metaData.getColumnCount()];
					tempClazz = Integer.class;
				}
				for(int i=0;i<obj.length;i++){
					obj[i] = getColumnValueImpl(rs.getObject(i+1),tempClazz);
				}
				return (T) obj;
			}else if(clazz.equals(Map.class)){
				ResultSetMetaData metaData = rs.getMetaData();
				Map map = new HashMap();
				for(int i=0;i<metaData.getColumnCount();i++){
					String columnName = metaData.getColumnName(i+1);
					Object value = rs.getObject(i+1);
					map.put(columnName, value);
				}
				return (T)map;
			}else{
				//普通结构
				t = getColumnValueImpl(rs.getObject(1),clazz);
			}
		}
		return t;
	}
	/**
	 * 获取方法名字
	 * @param name 属性名字
	 * @param tag get/set
	 * @return
	 */
	private static String getMethodName(String name,String tag) {
		char nameFirst = name.charAt(0);
		name = String.valueOf(nameFirst).toUpperCase()+name.substring(1,name.length());
		return tag+name;
	}

	@SuppressWarnings("unchecked")
	private static <T> T getColumnValueImpl(Object obj,Class<T> clazz) {
		if(clazz.equals(int.class) || clazz.equals(Integer.class)
				|| clazz.equals(long.class) || clazz.equals(Long.class)
				|| clazz.equals(double.class) || clazz.equals(Double.class)){
			if(obj == null){
				return (T)new Integer(0);
			}
		}else if(clazz.equals(boolean.class) || clazz.equals(Boolean.class)){
			if(obj == null){
				return (T)new Boolean(false);
			}else{
				return (T)new Boolean((Integer)obj == 1);
			}
		}
		return (T) obj;
	}
	/**
	 * 插入数据
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	public static <T extends Model> int insert(T model) throws Exception{
		Class<?> clazz = model.getClass();
		Table table = clazz.getAnnotation(Table.class);
		if(null == table)throw new Exception(clazz.getName()+" not is Table !!!");
		String tableName = table.name();
		List<Method> methodList = SQL_CLASS_METHOD_INSERT.get(tableName);
		if(null == methodList){
			checkColumn(clazz, tableName);
			methodList = SQL_CLASS_METHOD_INSERT.get(tableName);
		}
		Object objs[] = getValueByMethod(model,methodList);
		
		String sql = SQL_CLASS_INSERT.get(tableName);
		sql = String.format(sql,objs);
		return executeSql(sql);
	}

	/**
	 * 更新数据
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public static <T extends Model> int update(T model) throws Exception{
		Class<?> clazz = model.getClass();
		Table table = clazz.getAnnotation(Table.class);
		if(null == table)throw new Exception(clazz.getName()+" not is Table !!!");
		String tableName = table.name();
		List<Method> methodList = new ArrayList<Method>();
		methodList.addAll(SQL_CLASS_METHOD_SET.get(tableName));
		methodList.addAll(SQL_CLASS_METHOD_WHERE.get(tableName));
		Object[] objs = getValueByMethod(model, methodList);
		
		String sql = SQL_CLASS_UPDATE.get(tableName);
		sql = String.format(sql, objs);
		return executeSql(sql);
	}
	/**
	 * 删除数据
	 * @param model
	 * @return
	 */
	public static <T extends Model> int delete(T model) throws Exception{
		Class<?> clazz = model.getClass();
		Table table = clazz.getAnnotation(Table.class);
		if(null == table)throw new Exception(clazz.getName()+" not is Table !!!");
		String tableName = table.name();
		List<Method> methodList = SQL_CLASS_METHOD_WHERE.get(tableName);
		Object[] objs = getValueByMethod(model, methodList);

		String sql = SQL_CLASS_DELETE.get(tableName);
		sql = String.format(sql, objs);
		return executeSql(sql);
	}

	private static void log(String sql) {
		if(showLog==false)return;
		if(sql.equals("show tables"))return;
		System.out.println(sql);
	}
	public static void showLog(boolean bl){
		showLog = bl;
	}
	public static void main(String[] args) {
//		MySqlUtil.instance();
//		String title = "<br>dd</br>";
//		title = title.replaceAll("<", "");
//		title = title.replaceAll(">", "");
//		title = title.replaceAll("/", "");
//		System.out.println(title);
//		System.out.println("aa'bb".replaceFirst("\'", "111"));
	}
}
