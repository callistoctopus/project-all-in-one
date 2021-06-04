package com.callistoctopus.springbootcaching.beans;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class MyBeans {

    @Cacheable("piDecimals")
    public int computePiDecimal(int i) {
        return i;
    }

}