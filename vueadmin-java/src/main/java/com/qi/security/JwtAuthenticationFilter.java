package com.qi.security;

import cn.hutool.core.util.StrUtil;
import com.qi.entity.SysUser;
import com.qi.service.SysUserService;
import com.qi.utils.JwtUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    UserDetailServiceImpl userDetailService;

    @Autowired
    SysUserService sysUserService;

    public JwtAuthenticationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        log.info("jwt 校验 filter");
        String jwt = request.getHeader(jwtUtils.getHeader());
        log.info("jwt: "+jwt);
        if (StrUtil.isBlankOrUndefined(jwt)) {
            chain.doFilter(request, response);
            return;
        }

        Claims claim = jwtUtils.getClaimByToken(jwt);
        if (claim == null) {
            throw new JwtException("token 异常");
        }
        if (jwtUtils.isTokenExpired(claim)) {
            throw new JwtException("token已过期");
        }

        String username = claim.getSubject();
        // 获取用户的权限等信息
        log.info("用户-{}，正在登陆！", username);
        SysUser sysUser = sysUserService.getByUsername(username);
        UsernamePasswordAuthenticationToken token
                = new UsernamePasswordAuthenticationToken(username, null, userDetailService.getUserAuthority(sysUser.getId()));

        SecurityContextHolder.getContext().setAuthentication(token);

        chain.doFilter(request, response);
    }
}