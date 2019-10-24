package com.neusoft.util;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

@Component
@Aspect
public class AopDemo {

    Logger logger=Logger.getLogger(AopDemo.class);
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Pointcut("execution(public * com.neusoft.controller.*.*(..))")
    public void pointcut(){

    }

    @Before("pointcut()")
    public void before(JoinPoint point){
        String methodName=point.getSignature().getName();
        System.out.println("方法调用前");
        System.out.println("方法名:"+methodName+"\n类型:"+point.getTarget().getClass().getName());
//        logger.debug();
//        logger.info();
//        logger.warn();
//        logger.error();
//        logger.trace();
    }

    @After("pointcut()")
    public void after(JoinPoint point){
        String methodName=point.getSignature().getName();
        System.out.println("方法调用后");
        System.out.println("方法名:"+methodName+"\n类型:"+point.getTarget().getClass().getName());
    }

    @AfterReturning(pointcut = "pointcut()",returning = "obj")
    public void returning(JoinPoint point,Object obj){
        System.out.println("返回值");
        System.out.println("方法名:"+point.getSignature().getName()+"\n类型:"+point.getTarget().getClass().getName());
        System.out.println("返回类型："+obj.getClass().getName());
    }

    @Around("pointcut()")
    public Object around(ProceedingJoinPoint point) throws Throwable{
        System.out.println("方法名:"+point.getSignature().getName()+"\n类型:"+point.getTarget().getClass().getName());
        long startime=System.currentTimeMillis();
        Object obj=point.proceed();
        long endtime=System.currentTimeMillis();
        System.out.println("耗时："+(endtime-startime)+"毫秒");

        logger.info(sdf.format(new Date()));
        logger.info(point.getTarget().getClass().getName()+"."+point.getSignature().getName());
        logger.info("耗时："+(endtime-startime)+"毫秒");
        return obj;
    }
}
