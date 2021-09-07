package com.qi.security;

import cn.hutool.json.JSONUtil;
import com.qi.common.lang.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    // 权限不足
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

        log.info("权限不够！！");
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);   //  403

        ServletOutputStream outputStream = response.getOutputStream();

        Result result = Result.fail(accessDeniedException.getMessage());

        outputStream.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));

        outputStream.flush();
        outputStream.close();

    }
}