package com.hanpang.framework.base.exception;
/**
 * 自定义异常RBACException
 * @author 刘文铭
 *
 */
public class RbacException extends RuntimeException {
	private static final long serialVersionUID = -3735261369843925281L;

	public RbacException() {
		super();
	}

	public RbacException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public RbacException(String message, Throwable cause) {
		super(message, cause);
	}

	public RbacException(String message) {
		super(message);
	}

	public RbacException(Throwable cause) {
		super(cause);
	}

}
