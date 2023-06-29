import {get} from './http';
import {postformdata} from './http';
import {getformdata} from './http';
// 集成平台服务器状态

export const add = p =>postformdata(`add`,p)

export const getMenuList = p =>get(`getMenuList`)

export const getContent = p =>postformdata(`getContent`,p)
export const getPredict = p =>postformdata(`getPredict`,p)

