package com.qi.mapper;

import com.qi.entity.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author qi-chao
 * @since 2021-09-05
 */

@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
    List<Long> getNavMenuIds(Long userId);

    List<SysUser> listByMenuId(Long menuId);
}
