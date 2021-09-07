package com.qi.service;

import com.qi.common.dto.SysMenuDto;
import com.qi.entity.SysMenu;
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
public interface SysMenuService extends IService<SysMenu> {

    List<SysMenuDto> getCurrentUserNav();

    List<SysMenu> tree();
}
