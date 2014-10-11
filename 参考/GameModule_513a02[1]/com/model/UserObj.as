package com.model
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.netease.protobuf.*;
    import com.staticdata.*;
    import flash.events.*;
    import interfaces.role.*;

    public class UserObj extends BaseEventDispatcher
    {
        private var _playerInfo:PlayerInfo;
        private var _equipsInfo:EquipsInfo;
        private var _line:int;
        private var _selectRole:IRole;
        private var _backpackInfo:BackpackInfo;
        private var _lastLoginTime:uint;
        private var _heros:Array;
        private var _herosStandBy:Array;
        private var _fighting:Boolean;
        private var _state:String = "";
        public static const HEROS_UPDATE:String = "heroUpdate";
        public static const SUB_HERO_NUM_CHANGE:String = "SUB_HERO_NUM_CHANGE";
        public static const PLAYER_KONGFU_SCORE_CHANGE:String = "SUB_HERO_KONGFU_CHANGE";
        public static const PLAYER_STUDIED_KONGFU:String = "PlayerStudiedKongfu";
        public static const SERVANTS_UPDATED:String = "ServantsUpdated";
        public static var keyable:Boolean = true;
        private static var instance:UserObj;

        public function UserObj()
        {
            this._heros = [];
            this._herosStandBy = [];
            this._playerInfo = new PlayerInfo();
            this._backpackInfo = new BackpackInfo();
            this._equipsInfo = new EquipsInfo();
            return;
        }// end function

        public function get selectRole() : IRole
        {
            return this._selectRole;
        }// end function

        public function set selectRole(param1:IRole) : void
        {
            var _loc_2:* = false;
            if (this._selectRole != param1)
            {
                if (this._selectRole)
                {
                    this._selectRole.unSelect();
                    this._selectRole.alwaysShowBloodStripe = false;
                }
                _loc_2 = true;
                if (this._selectRole && this._selectRole.isPlayer() && param1 && param1.isMonster() && param1.info.monster_type == 1)
                {
                    _loc_2 = false;
                }
                if (param1)
                {
                    param1.select();
                    param1.alwaysShowBloodStripe = true;
                }
                this._selectRole = param1;
                dispatchEvent(new GameEvent(GameEvent.CHANGE_SELECT_ROLE, _loc_2));
            }
            return;
        }// end function

        public function get equipsInfo() : EquipsInfo
        {
            return this._equipsInfo;
        }// end function

        public function set equipsInfo(param1:EquipsInfo) : void
        {
            this._equipsInfo = param1;
            return;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            if (param1 != this._line)
            {
                this._line = param1;
                dispatchEvent(new GameEvent(GameEvent.LINE_CHANGE));
            }
            this._line = param1;
            return;
        }// end function

        public function get backpackInfo() : BackpackInfo
        {
            return this._backpackInfo;
        }// end function

        public function set backpackInfo(param1:BackpackInfo) : void
        {
            this._backpackInfo = param1;
            return;
        }// end function

        public function get playerInfo() : PlayerInfo
        {
            return this._playerInfo;
        }// end function

        public function set playerInfo(param1:PlayerInfo) : void
        {
            this._playerInfo = param1;
            return;
        }// end function

        public function set herosStandBy(param1:Array) : void
        {
            this._herosStandBy = param1;
            return;
        }// end function

        public function get heros() : Array
        {
            return this._heros;
        }// end function

        public function getHeroLstBySeq() : Array
        {
            var _loc_4:* = null;
            var _loc_1:* = this.heros;
            var _loc_2:* = [];
            var _loc_3:* = [];
            for each (_loc_4 in _loc_1)
            {
                
                if (this._herosStandBy.indexOf(_loc_4.personId.toString()) > -1)
                {
                    _loc_2.push(_loc_4);
                    continue;
                }
                _loc_3.push(_loc_4);
            }
            return [_loc_2, _loc_3];
        }// end function

        public function get lastLoginTime() : uint
        {
            return this._lastLoginTime;
        }// end function

        public function set lastLoginTime(param1:uint) : void
        {
            this._lastLoginTime = param1;
            return;
        }// end function

        public function isTodayFirstLogin() : Boolean
        {
            var _loc_1:* = new Date();
            _loc_1.time = this._lastLoginTime;
            var _loc_2:* = new Date();
            _loc_2.time = ToolKit.getServerTime();
            if (_loc_1.fullYear == _loc_2.fullYear && _loc_1.month == _loc_2.month && _loc_1.day == _loc_2.day)
            {
                return true;
            }
            return false;
        }// end function

        public function get fighting() : Boolean
        {
            return this._fighting;
        }// end function

        public function set fighting(param1:Boolean) : void
        {
            this._fighting = param1;
            return;
        }// end function

        public function getSubHeroNumByUserLevel(param1:uint = 0) : int
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            if (param1 == 0)
            {
                param1 = this._playerInfo.level;
            }
            var _loc_2:* = [[1, 5], [6, 10], [11, 20], [21, 30], [31, 40], [41, 50], [51, 55], [56, 60]];
            var _loc_4:* = _loc_2.length;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = _loc_2[_loc_5];
                if (param1 >= _loc_3[0] && param1 <= _loc_3[1])
                {
                    return (_loc_5 + 1);
                }
                _loc_5++;
            }
            return -1;
        }// end function

        public function setCSPlayerInfo2UserInfo(param1) : void
        {
            dispatchEvent(new Event(SERVANTS_UPDATED));
            return;
        }// end function

        public function updateHero(param1) : RoleInfo
        {
            return null;
        }// end function

        public function handleStudyKongfuRsp(param1) : void
        {
            this.updateHero(param1);
            dispatchEvent(new Event(PLAYER_STUDIED_KONGFU));
            return;
        }// end function

        public function addOneHero(param1) : void
        {
            if (param1 == null)
            {
                Log.log(this + "addOneHero,fail. heroInfo is null.");
                return;
            }
            return;
        }// end function

        public function getHeroInfoByGuid(param1:UInt64) : RoleInfo
        {
            return null;
        }// end function

        public function delHeroInfoByGuid(param1:UInt64) : void
        {
            return;
        }// end function

        public function hasHeroByCfgID(param1:uint) : Boolean
        {
            return false;
        }// end function

        public function chechMoneyEnough(param1:uint) : Boolean
        {
            return this._playerInfo.money >= param1;
        }// end function

        public function chechGoldEnough(param1:uint) : Boolean
        {
            return this._playerInfo.gold >= param1;
        }// end function

        public function isNoviceGuide() : Boolean
        {
            if (this._playerInfo.level < 10)
            {
                return true;
            }
            return false;
        }// end function

        public function checkStat() : void
        {
            if (this._state == Params.LOGIN_REG)
            {
                dispatchEvent(new Event(Params.LOGIN_REG));
            }
            else if (this._state == Params.REG_OK)
            {
                dispatchEvent(new Event(Params.REG_OK));
            }
            else if (this._state == Params.LOGIN_OK)
            {
                Log.log("登录成功");
                dispatchEvent(new Event(Params.LOGIN_OK));
            }
            else
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11784") + this + "checkSate invalid,stat=" + this._state + ",pf=" + Params.pf);
            }
            return;
        }// end function

        public function setLoginReg() : void
        {
            this._state = Params.LOGIN_REG;
            dispatchEvent(new Event(Params.LOGIN_REG));
            return;
        }// end function

        public function setLoginOK() : void
        {
            this._state = Params.LOGIN_OK;
            return;
        }// end function

        public function canTrans() : Boolean
        {
            if (this._playerInfo.vipid >= 1)
            {
                return true;
            }
            return false;
        }// end function

        public function get playername() : String
        {
            return this.playerInfo.name;
        }// end function

        public function getBuffInfo(param1:uint) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.buffs;
            var _loc_4:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                if ((_loc_2[_loc_5] as BuffInfo).q_buff_id == param1)
                {
                    return _loc_2[_loc_5];
                }
                _loc_5++;
            }
            return null;
        }// end function

        public function isLoginOK() : Boolean
        {
            return this._state == Params.LOGIN_OK || this._state == Params.REG_OK;
        }// end function

        public function setRegOK() : void
        {
            this._state = Params.REG_OK;
            dispatchEvent(new Event(Params.REG_OK));
            return;
        }// end function

        public static function getInstance() : UserObj
        {
            if (instance != null)
            {
                return instance;
            }
            instance = new UserObj;
            return instance;
        }// end function

        public static function clear() : void
        {
            instance = null;
            return;
        }// end function

        public static function getKingHeadPicBySex(param1:uint) : String
        {
            var _loc_2:* = null;
            if (param1 == SEX_TYPE.MALE)
            {
                _loc_2 = Params.ROLE_HEAD_PATH + "p0002.png";
            }
            else
            {
                _loc_2 = Params.ROLE_HEAD_PATH + "p0001.png";
            }
            return _loc_2;
        }// end function

    }
}
