package com.qi.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class bcPwd {
    public static void main(String[] args) {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String password = bCryptPasswordEncoder.encode("654321");

        boolean matches = bCryptPasswordEncoder.matches("654321", password);
        if (matches) {
            System.out.println("password：" + password);
        } else {
            System.out.println("匹配结果：" + matches);
        }

    }
}
