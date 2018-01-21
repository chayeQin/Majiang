package com.model;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 数据库注释(列)
 * @author	JOY
 *
 * @date	2015-8-13
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface Column {

	/**
	 * 是否是主键(默认false)
	 * @return
	 */
	boolean id() default false;

	/**
	 * 字段名字(默认读取属性名字)
	 * @return
	 */
	String name() default "";
	
	/**
	 * 字段长度(默认读取属性对应长度)
	 */
	int length() default 0;
	
	/**
	 * 字段的类型(默认读取属性类型)
	 */
	String type() default "";
	
	/**
	 * 是否是临时字段(默认存入数据库中)
	 * @return
	 */
	boolean temp() default false;
}
