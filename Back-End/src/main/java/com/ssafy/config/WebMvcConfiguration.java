package com.ssafy.config;

import java.util.Arrays;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;


@Configuration
@EnableAspectJAutoProxy
// root-context.xml에서 설정해두었던 autoproxy
// * asterisk 설정하면 ssafy 패키지 이하에 속하는 모든 패키지들의 mapper 다 포함
@MapperScan(basePackages = { "com.ssafy.**.model.dao" })
public class WebMvcConfiguration implements WebMvcConfigurer {

//	private final List<String> patterns = Arrays.asList("/board/*", "/admin", "/user/list");
//
//	@Autowired
//	private ConfirmInterceptor confirmInterceptor;

	private final String uploadFilePath;

	// application.properties에 지정한 upload-files 경로로 연결된다
	public WebMvcConfiguration(@Value("${file.path.upload-files}") String uploadFilePath) {
		this.uploadFilePath = uploadFilePath;
	}

	// REST API를 위한 crossorigin 설정하는 부분
//	@Override
//	public void addCorsMappings(CorsRegistry registry) {
//		registry.addMapping("/**").allowedOrigins("*")
////			.allowedOrigins("http://localhost:8080", "http://localhost:8081")
//				.allowedMethods(HttpMethod.GET.name(), HttpMethod.POST.name(), HttpMethod.PUT.name(),
//						HttpMethod.DELETE.name(), HttpMethod.HEAD.name(), HttpMethod.OPTIONS.name(),
//						HttpMethod.PATCH.name())
////				.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH", "HEAD")
//				.maxAge(1800);
//	}

// interceptor를 위한 설정
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(confirmInterceptor).addPathPatterns(patterns);
//	}

	
// fileupload를 위한 요청 경로와 실제 경로 mapping 설정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/file/**").addResourceLocations("file:///" + uploadFilePath + "/")
				.setCachePeriod(3600).resourceChain(true).addResolver(new PathResourceResolver());
	}

}
