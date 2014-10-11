package com.model
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.path.*;
    import com.game.fight.bean.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class RoleList extends Object
    {
        private var _player:IRole;
        private var _roles:Dictionary;
        private var _monsterTypeDic:Dictionary;
        private var _hasSelected:Array;
        public var nearMonstersList:Vector.<IRole>;
        private var _hateMap:Object;
        private const _viewRange:int = 250000;
        private static var instance:RoleList;
        public static const NEAR_RANGE:int = 302500;
        public static const FIND_MONSTER_PATH_LIMIT:uint = 70;

        public function RoleList()
        {
            this._hasSelected = new Array();
            this.nearMonstersList = new Vector.<IRole>;
            this._hateMap = {};
            TimerManager.registerTimer(13, 0, this.refreshHateMap);
            return;
        }// end function

        public function get roles() : Dictionary
        {
            return this._roles;
        }// end function

        public function get player() : IRole
        {
            return this._player;
        }// end function

        public function set player(param1:IRole) : void
        {
            if (param1)
            {
                this._player = param1;
            }
            return;
        }// end function

        public function reset() : void
        {
            this._roles = new Dictionary();
            this._monsterTypeDic = new Dictionary();
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.MONSTER_TYPE_LIST_RESET));
            return;
        }// end function

        public function addRole(param1:IRole) : void
        {
            var _loc_2:* = 0;
            if (param1 && param1.info)
            {
                this._roles[param1.info.personId.toString()] = param1;
                if (param1.info is MonsterInfo)
                {
                    _loc_2 = param1.info.cfgId;
                    if (!this._monsterTypeDic[_loc_2])
                    {
                        this._monsterTypeDic[_loc_2] = [];
                    }
                    this._monsterTypeDic[_loc_2].push(param1);
                    if (this._monsterTypeDic[_loc_2].length == 1)
                    {
                        FrameworkGlobal.sendMsg(new GameEvent(GameEvent.MONSTER_TYPE_LIST_ADD, _loc_2));
                    }
                }
            }
            return;
        }// end function

        public function removeRole(param1:IRole) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1 && param1.info && param1.info.personId)
            {
                _loc_2 = param1.info.personId.toString();
                if (this._hateMap[_loc_2])
                {
                    this._hateMap[_loc_2] = null;
                    delete this._hateMap[_loc_2];
                }
            }
            if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole == param1)
            {
                UserObj.getInstance().selectRole = null;
            }
            if (param1.info)
            {
                _loc_3 = param1.info.personId.toString();
                if (this._roles[_loc_3])
                {
                    this._roles[_loc_3] = null;
                    delete this._roles[_loc_3];
                }
                if (param1.info is MonsterInfo && this._monsterTypeDic[param1.info.cfgId])
                {
                    _loc_4 = this._monsterTypeDic[param1.info.cfgId].indexOf(param1);
                    if (_loc_4 != -1)
                    {
                        (this._monsterTypeDic[param1.info.cfgId] as Array).splice(_loc_4, 1);
                        if (this._monsterTypeDic[param1.info.cfgId].length == 0)
                        {
                            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.MONSTER_TYPE_LIST_REMOVE, param1.info.cfgId));
                        }
                    }
                }
            }
            return;
        }// end function

        public function clearHate() : void
        {
            this._hateMap = {};
            return;
        }// end function

        public function getRole(param1:long) : IRole
        {
            if (this._roles && param1)
            {
                return this._roles[param1.toString()];
            }
            return null;
        }// end function

        public function getFirstRoleByModelId(param1:int) : IRole
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._roles)
            {
                
                if (_loc_2.info.cfgId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getMonsterTypeListByModelId(param1:int) : Array
        {
            return this._monsterTypeDic[param1] as Array;
        }// end function

        public function selectNearestRole(param1:IRole, param2:uint = 2) : IRole
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_3:* = this.getEnemy();
            if (_loc_3)
            {
                return _loc_3;
            }
            var _loc_8:* = 80;
            for each (_loc_9 in this._roles)
            {
                
                if (_loc_9.info.roleType == param2 || param2 == RoleType.ROLE_TYPE_MONSTER && _loc_9.info.roleType == RoleType.ROLE_TYPE_CLIENT_MONSTER)
                {
                    if (_loc_9.alive() && _loc_9.isEnemy())
                    {
                        _loc_6 = param1.distanceSQ(_loc_9);
                        if (_loc_6 < _loc_5 || _loc_5 == 0)
                        {
                            _loc_5 = _loc_6;
                            _loc_4 = _loc_9;
                        }
                        if (_loc_7++ > _loc_8)
                        {
                            break;
                        }
                    }
                }
            }
            return _loc_4;
        }// end function

        private function nextRole(param1:Array) : IRole
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = param1.length;
            if (_loc_2 <= 0)
            {
                return null;
            }
            var _loc_4:* = null;
            var _loc_6:* = int.MAX_VALUE;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_2)
            {
                
                _loc_5 = param1[_loc_7];
                if (!_loc_5.isUser() && _loc_5.alive())
                {
                    if (this._hasSelected.indexOf(_loc_5) != -1)
                    {
                    }
                    else
                    {
                        _loc_3 = this._player.distanceSQ(_loc_5);
                        if (_loc_3 < _loc_6 || _loc_6 == 0)
                        {
                            _loc_6 = _loc_3;
                            _loc_4 = _loc_5;
                        }
                    }
                }
                _loc_7++;
            }
            return _loc_4;
        }// end function

        public function selectedRoleRandom() : IRole
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_14:* = 0;
            var _loc_17:* = null;
            var _loc_6:* = 50;
            var _loc_7:* = new Array();
            var _loc_8:* = new Array();
            var _loc_9:* = new Array();
            var _loc_10:* = new Array();
            var _loc_11:* = new Array();
            var _loc_12:* = new Array();
            var _loc_13:* = new Array();
            if (UserObj.getInstance().selectRole)
            {
                this._hasSelected.push(UserObj.getInstance().selectRole);
            }
            var _loc_15:* = FrameworkGlobal.stageW >> 1;
            var _loc_16:* = FrameworkGlobal.stageH >> 1;
            for each (_loc_17 in this._roles)
            {
                
                if (!_loc_17.info)
                {
                    continue;
                }
                _loc_14 = _loc_17.info.roleType;
                if (!(Global.sceneManager.currentScene as SimpleScene).isAtScene(_loc_17._x, _loc_17._y))
                {
                    continue;
                }
                if (!(this._player._x - _loc_17._x < _loc_15 && this._player._x - _loc_17._x > -_loc_15 && this._player._y - _loc_17._y < _loc_16 && this._player._y - _loc_17._y > -_loc_16))
                {
                    continue;
                }
                if (_loc_14 == RoleType.ROLE_TYPE_PLAYER && _loc_17.isEnemy())
                {
                    _loc_7.push(_loc_17);
                    continue;
                }
                if (_loc_14 == RoleType.ROLE_TYPE_MONSTER && RoleType.ROLE_TYPE_CLIENT_MONSTER && _loc_17.info.mapId != Params.COUNTRY_MAP_ID)
                {
                    _loc_10.push(_loc_17);
                    continue;
                }
                if (_loc_14 == RoleType.ROLE_TYPE_SUMMON_PET && _loc_17.isEnemy())
                {
                    _loc_9.push(_loc_17);
                }
            }
            _loc_2 = this.nextRole(_loc_7);
            if (!_loc_2)
            {
                _loc_2 = this.nextRole(_loc_10);
            }
            if (!_loc_2)
            {
                _loc_2 = this.nextRole(_loc_9);
            }
            if (_loc_2)
            {
                this._hasSelected.push(_loc_2);
                if (this._hasSelected.length > 3)
                {
                    this._hasSelected.splice(0, this._hasSelected.length);
                }
                return _loc_2;
            }
            else
            {
                _loc_2 = this._hasSelected.shift();
                if (_loc_2 && _loc_2.alive())
                {
                    this._hasSelected.push(_loc_2);
                    return _loc_2;
                }
                this._hasSelected.splice(0, this._hasSelected.length);
                return null;
            }
        }// end function

        private function sortRoles(param1:RoleInfo, param2:RoleInfo) : void
        {
            return;
        }// end function

        public function getNearestMounsterByType(param1:Vector.<int> = null, param2:IRole = null, param3:ByteArray = null) : IRole
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.nearMonstersList.length = 0;
            var _loc_5:* = 35 * MapUtils.GRID_BORDER * 35 * MapUtils.GRID_BORDER;
            for each (_loc_8 in this._roles)
            {
                
                if (!_loc_8.info)
                {
                    trace(_loc_8);
                    continue;
                }
                if (_loc_8.info.roleType == RoleType.ROLE_TYPE_MONSTER || _loc_8.info.roleType == RoleType.ROLE_TYPE_CLIENT_MONSTER)
                {
                    if (_loc_8.alive() && _loc_8.isEnemy())
                    {
                        _loc_4 = this.player.distanceSQ(_loc_8);
                        if (_loc_4 < NEAR_RANGE && (!param2 || param2 && param2 != _loc_8))
                        {
                            this.nearMonstersList.push(_loc_8);
                        }
                        if (param1 && param1.length && param1.indexOf(_loc_8.info.cfgId) == -1)
                        {
                            continue;
                        }
                        if (_loc_4 < _loc_5 && (!param2 || param2 && param2 != _loc_8))
                        {
                            if (MapUtils.coo2Tile(this.player._x) == MapUtils.coo2Tile(_loc_8._x) && MapUtils.coo2Tile(this.player._y) == MapUtils.coo2Tile(_loc_8._y))
                            {
                                _loc_5 = _loc_4;
                                _loc_6 = _loc_8;
                                continue;
                            }
                            if (param3)
                            {
                                _loc_7 = MapUtils.findPath(param3, MapUtils.coo2Tile(this.player._x), MapUtils.coo2Tile(this.player._y), MapUtils.coo2Tile(_loc_8._x), MapUtils.coo2Tile(_loc_8._y), 0, FIND_MONSTER_PATH_LIMIT);
                                if (_loc_7)
                                {
                                    _loc_5 = _loc_4;
                                    _loc_6 = _loc_8;
                                }
                                continue;
                            }
                            _loc_5 = _loc_4;
                            _loc_6 = _loc_8;
                        }
                    }
                }
            }
            _loc_9 = MapCfgObj.getInstance().getMap(this.player.info.mapId);
            if (_loc_9.q_battle_type == 0)
            {
                _loc_10 = this.getEnemy(param3);
                if (_loc_10)
                {
                    return _loc_10;
                }
            }
            return _loc_6;
        }// end function

        public function pushNearList() : void
        {
            var _loc_1:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.nearMonstersList.length = 0;
            var _loc_2:* = int.MAX_VALUE;
            for each (_loc_4 in this._roles)
            {
                
                if (_loc_4.info.roleType == RoleType.ROLE_TYPE_MONSTER || _loc_4.info.roleType == RoleType.ROLE_TYPE_CLIENT_MONSTER)
                {
                    if (_loc_4.alive())
                    {
                        _loc_1 = this.player.distanceSQ(_loc_4);
                        if (_loc_1 < NEAR_RANGE)
                        {
                            this.nearMonstersList.push(_loc_4);
                        }
                    }
                }
            }
            return;
        }// end function

        public function hateRecord(param1:AttackResultInfo) : void
        {
            var _loc_2:* = param1.sourceId.toString();
            var _loc_3:* = this._roles[_loc_2] as IRole;
            if (_loc_3.info.roleType == RoleType.ROLE_TYPE_MONSTER || _loc_3.info.roleType == RoleType.ROLE_TYPE_CLIENT_MONSTER)
            {
                this._hateMap[_loc_2] = int(this._hateMap[_loc_2]) + param1.damage;
            }
            return;
        }// end function

        private function refreshHateMap(event:TimerManagerEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            for (_loc_3 in this._hateMap)
            {
                
                _loc_2 = this._roles[_loc_3] as IRole;
                if (_loc_2)
                {
                    _loc_4 = this.player.distanceSQ(_loc_2);
                    if (_loc_4 > this._viewRange)
                    {
                        delete _loc_6[_loc_3];
                    }
                    continue;
                }
                delete _loc_6[_loc_3];
            }
            return;
        }// end function

        public function getEnemy(param1:ByteArray = null) : IRole
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = null;
            for (_loc_5 in this._hateMap)
            {
                
                _loc_3 = this._roles[_loc_5] as IRole;
                if (_loc_3)
                {
                    _loc_6 = this.player.distanceSQ(_loc_3);
                    if (_loc_6 < this._viewRange)
                    {
                        if (_loc_2)
                        {
                            if (param1)
                            {
                                _loc_4 = MapUtils.findPath(param1, MapUtils.coo2Tile(this.player._x), MapUtils.coo2Tile(this.player._y), MapUtils.coo2Tile(_loc_3._x), MapUtils.coo2Tile(_loc_3._y), 0, FIND_MONSTER_PATH_LIMIT);
                                if (_loc_4 && _loc_8[_loc_5] > _loc_8[_loc_2])
                                {
                                    _loc_2 = _loc_5;
                                }
                            }
                            continue;
                        }
                        if (param1)
                        {
                            _loc_4 = MapUtils.findPath(param1, MapUtils.coo2Tile(this.player._x), MapUtils.coo2Tile(this.player._y), MapUtils.coo2Tile(_loc_3._x), MapUtils.coo2Tile(_loc_3._y), 0, FIND_MONSTER_PATH_LIMIT);
                            if (_loc_4)
                            {
                                _loc_2 = _loc_5;
                            }
                            continue;
                        }
                        _loc_2 = _loc_5;
                    }
                }
            }
            return this._roles[_loc_2];
        }// end function

        public function getNearFriend(param1:int) : Vector.<IRole>
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = new Vector.<IRole>;
            for each (_loc_3 in this._roles)
            {
                
                if (_loc_3.info.roleType == RoleType.ROLE_TYPE_PLAYER)
                {
                    if (_loc_3.alive() && _loc_3.isFriend())
                    {
                        _loc_4 = this.player.distanceSQ(_loc_3);
                        _loc_4 = Math.sqrt(_loc_4);
                        if (_loc_4 < param1)
                        {
                            _loc_2.push(_loc_3);
                        }
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : RoleList
        {
            if (instance == null)
            {
                instance = new RoleList;
            }
            return instance;
        }// end function

    }
}
