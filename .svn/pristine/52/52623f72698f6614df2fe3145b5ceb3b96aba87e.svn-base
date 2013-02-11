package com.igz.facebook;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;

import com.google.gson.Gson;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

/*
 * Single Bean 
 * http://developers.facebook.com/docs/authentication/signed_request/
 */
public final class FacebookRequest {
	private static String fbSecretKey = "d40803605ad70a7f619eab56a271c5c0";
	private static String fbAppId = "253130971383304";
	private static String fbCanvasPage = "http://lending-books.appspot.com/login.facebook.jsp";
	private static String fbCanvasUrl = "http://lending-books.appspot.com/";

	private FacebookRequest() {
	}

	public static FacebookRequest fromSignedRequest(String p_signed_request) throws Exception {
		FacebookRequest data = null;
		if (p_signed_request != null) {
			// it is important to enable url-safe mode for Base64 encoder
			Base64 base64 = new Base64();
			// split request into signature and data
			String[] signedRequest = p_signed_request.split("\\.", 2);
			// parse signature
			String sig = new String(base64.decode(signedRequest[0].getBytes("UTF-8")));
			String plainRequest = new String(base64.decode(signedRequest[1].getBytes("UTF-8")));
			// parse data and convert to json object
			System.out.println(plainRequest);
			data = new Gson().fromJson(plainRequest, FacebookRequest.class);
			System.out.println(data.toString());

			// check signature algorithm
			if (!data.getAlgorithm().equals("HMAC-SHA256")) {
				// unknown algorithm is used
				return null;
			}
			// check if data is signed correctly
			if (!hmacSHA256(signedRequest[1], fbSecretKey).equals(sig)) {
				// signature is not correct, possibly the data was tampered with
				return null;
			}
			// check if user authorized the app
			if (data.getUserId() == null || data.getOauthToken() == null) { return null; }

		} else {
			return null;
		}
		return data;
	}

	private static String hmacSHA256(String data, String key) throws Exception {
		SecretKeySpec secretKey = new SecretKeySpec(key.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(secretKey);
		byte[] hmacData = mac.doFinal(data.getBytes("UTF-8"));
		return new String(hmacData);
	}

	@Override
	public String toString() {
		return String
				.format("FacebookRequest [code=%s, algorithm=%s, issued_at=%s, user_id=%s, user=%s, oauth_token=%s, expires=%s, app_data=%s, page=%s]", code, algorithm, issued_at, user_id, user, oauth_token, expires, app_data, page);
	}

	/*
	 * an OAuth Code which can be exchanged for a valid user access token via a
	 * subsequent server-side request
	 */
	private String code;

	/*
	 * A JSON string containing the mechanism used to sign the request,
	 * normally: HMAC-SHA256
	 */
	private String algorithm;
	/*
	 * A JSON number containing the Unix timestamp when the request was signed.
	 */
	private String issued_at;
	/*
	 * A JSON string containing the User ID of the current user.
	 */
	private String user_id;
	/*
	 * A JSON object containing the locale string, country string and the age
	 * object. See the Age Object table for actual min and max values.
	 */
	private User user;
	/*
	 * A JSON string that can be used when making requests to the Graph API.
	 * This is also known as a user access token.
	 */

	private String oauth_token;
	/*
	 * A JSON number containing the Unix timestamp when the oauth_token expires.
	 */
	private String expires;
	/*
	 * A JSON string containing the content of the app_data query string
	 * parameter which may be passed if the app is being loaded within a Page
	 * Tab.
	 */
	private String app_data;
	/*
	 * A JSON object containing the page id string, the liked boolean (set to
	 * true if the user has liked the page, false if not) and the admin boolean
	 * (set to true if the user is an admin of the page, false if they're not).
	 * This field is only present if your app is being loaded within a Page Tab.
	 */
	private String page;

	public String getCode() {
		return code;
	}

	public String getAlgorithm() {
		return algorithm;
	}

	public String getIssuedAt() {
		return issued_at;
	}

	public String getUserId() {
		return user_id;
	}

	public User getUser() {
		return user;
	}

	public String getOauthToken() {
		return oauth_token;
	}

	public String getExpires() {
		return expires;
	}

	public String getAppData() {
		return app_data;
	}

	public String getPage() {
		return page;
	}

}
