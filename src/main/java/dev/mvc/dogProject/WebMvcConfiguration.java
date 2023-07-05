package dev.mvc.dogProject;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import dev.mvc.goods.Goods;
import dev.mvc.notice.Notice;
import dev.mvc.qna.Qna;
import dev.mvc.recipe.Recipe;
import dev.mvc.review.Review;
import dev.mvc.tool.Tool;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer{
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Windows: path = "C:/kd/deploy/resort_v2sbm3c_blog/contents/storage";
        // ▶ file:///C:/kd/deploy/resort_v2sbm3c_blog/contents/storage
      
        // Ubuntu: path = "/home/ubuntu/deploy/resort_v2sbm3c_blog/contents/storage";
        // ▶ file:////home/ubuntu/deploy/resort_v2sbm3c_blog/contents/storage
      
        // JSP 인식되는 경로: http://localhost:9091/contents/storage";
         registry.addResourceHandler("/dogproject/goods/storage/**").addResourceLocations("file:///" +  Goods.getUploadDir());  
        
        // JSP 인식되는 경로: http://localhost:9091/attachfile/storage";
        registry.addResourceHandler("/dogproject/recipe/storage/**").addResourceLocations("file:///" +  Recipe.getUploadDir());
        
        // JSP 인식되는 경로: http://localhost:9091/member/storage";
        registry.addResourceHandler("/dogproject/notice/storage/**").addResourceLocations("file:///" +  Notice.getUploadDir());
        registry.addResourceHandler("/dogproject/qna/storage/**").addResourceLocations("file:///" +  Qna.getUploadDir());
        registry.addResourceHandler("/dogproject/review/storage/**").addResourceLocations("file:///" +  Review.getUploadDir());
    }
 
}