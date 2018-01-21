package com.model;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 数据库注解(表)
 * @author	JOY
 *
 * @date	2015-8-13
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface Table {
	String name();//名字
	/**
	 * 是否是数据库表
	 */
	boolean isDataBase() default true;
}
