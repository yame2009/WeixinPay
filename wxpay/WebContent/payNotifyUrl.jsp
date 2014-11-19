<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.wxap.util.TenpayUtil"%>
<%@ page import="com.wxap.util.MD5Util"%>
<%@ page import="com.wxap.RequestHandler"%>
<%@ page import="com.wxap.ResponseHandler"%>
<%@ page import="com.wxap.client.TenpayHttpClient"%>
<%@ include file="config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
System.out.println("-----------------微信支付来消息啦--------------------------");
ResponseHandler resHandler = new ResponseHandler(request,response);
resHandler.setKey(PARTNER_KEY);

if (resHandler.isValidSign() == true) {
	if (resHandler.isWXsign() == true) {
		// 商户订单号
		String out_trade_no = resHandler
				.getParameter("out_trade_no");
		// 财付通订单号
		String transaction_id = resHandler
				.getParameter("transaction_id");
		// 金额,以分为单位
		String total_fee = resHandler.getParameter("total_fee");
		// 如果有使用折扣券，discount有值，total_fee+discount=原请求的total_fee
		String discount = resHandler.getParameter("discount");
		// 支付结果
		String trade_state = resHandler
				.getParameter("trade_state");
		System.out.println("支付的订单号：" + out_trade_no);
		// 判断签名及结果
		if ("0".equals(trade_state)) {
			System.out.println("哈哈，微信支付成功了");
			// ------------------------------
			// 即时到账处理业务开始
			// ------------------------------
			// 处理数据库逻辑
			// 注意交易单不要重复处理
			// 注意判断返回金额
			// ------------------------------
			// 即时到账处理业务完毕
			// ------------------------------
			System.out.println("success 后台通知成功");
			// 给财付通系统发送成功信息，财付通系统收到此结果后不再进行后续通知
			resHandler.sendToCFT("success");
		} else {// sha1签名失败
			System.out.println("fail -SHA1 failed");
			resHandler.sendToCFT("fail");
		}
	} else {// MD5签名失败
		System.out.println("fail -Md5 failed");
	}
}

%>

