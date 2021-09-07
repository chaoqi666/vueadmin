package com.qi.service;

import com.qi.entity.SysRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qi-chao
 * @since 2021-09-05
 */
public interface SysRoleService extends IService<SysRole> {
    List<SysRole> listRolesByUserId(Long userId);
}
