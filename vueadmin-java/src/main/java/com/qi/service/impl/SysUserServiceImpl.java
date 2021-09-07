package com.qi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qi.entity.SysMenu;
import com.qi.entity.SysRole;
import com.qi.entity.SysUser;
import com.qi.mapper.SysUserMapper;
import com.qi.service.SysMenuService;
import com.qi.service.SysRoleService;
import com.qi.service.SysUserService;
import com.qi.utils.RedisUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qi-chao
 * @since 2021-09-05
 */

@Slf4j
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    @Autowired
    SysRoleService sysRoleService;

    @Autowired
    SysUserMapper sysUserMapper;

    @Autowired
    SysMenuService sysMenuService;

    @Autowired
    RedisUtil redisUtil;

    @Override
    public SysUser getByUsername(String username) {
        return getOne(new QueryWrapper<SysUser>().eq("username", username));
    }

    @Override
    public String getUserAuthorityInfo(Long userId) {

        SysUser sysUser = sysUserMapper.selectById(userId);
        log.info("sysUser: "+sysUser);
        //  ROLE_admin,ROLE_normal,sys:user:list,....
        String authority = "";

        // 优先从缓存获取
        if (redisUtil.hasKey("GrantedAuthority:" + sysUser.getUsername())) {
            authority = (String) redisUtil.get("GrantedAuthority:" + sysUser.getUsername());
            log.info("authority: "+authority);

        } else {
            // 获取角色编码
            List<SysRole> roles = sysRoleService.list(new QueryWrapper<SysRole>()
                    .inSql("id", "select role_id from sys_user_role where user_id = " + userId));

            if (roles.size() > 0) {
                String roleCodes = roles.stream().map(r -> "ROLE_" + r.getCode()).collect(Collectors.joining(","));
                authority = roleCodes.concat(",");
                log.info("authority: "+authority);
            }

            // 获取菜单操作编码
            List<Long> menuIds = sysUserMapper.getNavMenuIds(userId);
            if (menuIds.size() > 0) {

                List<SysMenu> menus = sysMenuService.listByIds(menuIds);
                String menuPerms = menus.stream().map(m -> m.getPerms()).collect(Collectors.joining(","));

                authority = authority.concat(menuPerms);
            }

            redisUtil.set("GrantedAuthority:" + sysUser.getUsername(), authority, 60 * 60);
        }

        return authority;
    }

    // 删除某个用户的权限信息
    @Override
    public void clearUserAuthorityInfo(String username) {
        redisUtil.del("GrantedAuthority:" + username);
    }

    // 删除所有与该角色关联的用户的权限信息
    @Override
    public void clearUserAuthorityInfoByRoleId(Long roleId) {

        List<SysUser> sysUsers = this.list(new QueryWrapper<SysUser>()
                .inSql("id", "select user_id from sys_user_role where role_id = " + roleId));

        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfo(u.getUsername());
        });

    }

    // 删除所有与该菜单关联的所有用户的权限信息
    @Override
    public void clearUserAuthorityInfoByMenuId(Long menuId) {
        List<SysUser> sysUsers = sysUserMapper.listByMenuId(menuId);

        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfo(u.getUsername());
        });
    }
}