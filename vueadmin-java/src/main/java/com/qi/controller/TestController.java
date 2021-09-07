package com.qi.controller;

import com.qi.common.lang.Result;
import com.qi.service.SysUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class TestController {

    @Autowired
    SysUserService sysUserService;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @PreAuthorize("hasRole('admin')")
    @GetMapping("/test")
    public Result test() {
        return Result.success(sysUserService.list());
    }

    // 普通用户、超级管理员
    @PreAuthorize("hasAuthority('sys:user:list')")
    @GetMapping("/test/pass")
    public Result pass() {

        // 加密后密码
        String password = bCryptPasswordEncoder.encode("654321");

        boolean matches = bCryptPasswordEncoder.matches("654321", password);

        System.out.println("匹配结果：" + matches);

        log.info("password:"+password);;
        return Result.success(password);
    }

}