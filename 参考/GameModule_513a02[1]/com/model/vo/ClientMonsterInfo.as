package com.model.vo
{
    import com.cfg.obj.*;
    import com.f1.utils.path.*;
    import com.staticdata.*;

    public class ClientMonsterInfo extends MonsterInfo
    {
        public var clientMonSkillList:Array;
        public var dropList:Array;
        public var moneyDrop:int;
        public var monExp:int;
        public var round:int;
        public var isNeedAutoMove:Boolean = true;
        public var autoMoveRange:int = 8;
        public var monAlertRange:int = 0;
        public var talkContent:Array;
        public var talkPercent:Array;

        public function ClientMonsterInfo()
        {
            return;
        }// end function

        public function conByObj(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            _cfgId = param1.q_monster_model;
            _loc_2 = MonsterCfgObj.getInstance().getMonsterObjCfg(cfgId);
            if (String(param1.q_skilllist) != "")
            {
                _loc_3 = String(param1.q_skilllist).split(";");
            }
            else
            {
                _loc_3 = [];
            }
            this.clientMonSkillList = [];
            for each (_loc_4 in _loc_3)
            {
                
                this.clientMonSkillList.push(int(_loc_4));
            }
            if (String(param1.q_drop) != "")
            {
                this.dropList = String(param1.q_drop).split(";");
            }
            else
            {
                this.dropList = [];
            }
            this.moneyDrop = int(param1.q_drop_money);
            showID = _loc_2.q_sculpt_resid;
            this.monExp = int(param1.q_exp);
            dir = param1.q_dir;
            direct = MapUtils.mapDirect2RoleDir(dir);
            _level = _loc_2.q_grade;
            _mapId = param1.q_map_id;
            var _loc_10:* = param1.q_hp;
            _hp = param1.q_hp;
            _hpMax = _loc_10;
            _speed = param1.q_speed;
            var _loc_5:* = MapUtils.tile2Coo([param1.q_x, param1.q_y]);
            x = _loc_5[0];
            y = _loc_5[1];
            _roleType = RoleType.ROLE_TYPE_CLIENT_MONSTER;
            _name = _loc_2.q_name;
            this.round = param1.q_create_num;
            this.monAlertRange = param1.q_patrol;
            this.isNeedAutoMove = param1.q_evasive_style == 0 ? (false) : (true);
            this.talkPercent = [];
            this.talkContent = [];
            var _loc_6:* = 0;
            var _loc_7:* = param1.q_talk.split(";");
            for each (_loc_9 in _loc_7)
            {
                
                _loc_8 = _loc_9.split("_");
                this.talkContent.push(_loc_8[1]);
                _loc_6 = _loc_6 + parseInt(_loc_8[0]) / 10000;
                this.talkPercent.push(_loc_6);
            }
            return;
        }// end function

    }
}
