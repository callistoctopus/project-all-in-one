#自定义异常显示页面
可在当前侧静态资源路径下添加/error文件夹
放置<code>.html页面即可



#AbstractErrorWebExceptionHandler 

//CustomErrorWebExceptionHandler.java
public class CustomErrorWebExceptionHandler extends AbstractErrorWebExceptionHandler {

    // Define constructor here

    @Override
    protected RouterFunction<ServerResponse> getRoutingFunction(ErrorAttributes errorAttributes) {

        return RouterFunctions
                .route(aPredicate, aHandler)
                .andRoute(anotherPredicate, anotherHandler);
    }

}