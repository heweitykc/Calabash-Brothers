package com.model.vo
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.buff.bean.*;
    import com.game.map.bean.*;
    import com.game.summonpet.bean.*;
    import com.model.*;
    import com.staticdata.*;

    public class MonsterInfo extends RoleInfo
    {
        private var _ownerName:String;
        private var _icon:String;
        public var friend:int;

        public function MonsterInfo()
        {
            return;
        }// end function

        public function set summonPetInfo(param1:SummonPetInfo) : void
        {
            _roleType = RoleType.ROLE_TYPE_SUMMON_PET;
            _cfgId = param1.petModelId + UserObj.getInstance().playerInfo.level;
            _personId = param1.petId;
            _level = param1.level;
            _hp = param1.hp;
            _hpMax = param1.maxHp;
            _mp = param1.mp;
            _mpMax = param1.maxMp;
            _sp = param1.sp;
            _spMax = param1.maxSp;
            this._ownerName = param1.ownerName;
            _owner = param1.ownerId;
            _mapId = param1.mapId;
            _x = param1.x;
            _y = param1.y;
            _speed = param1.speed;
            initBuffs(param1.buffs);
            _dir = param1.dir;
            direct = MapUtils.mapDirect2RoleDir(param1.dir);
            var _loc_2:* = MonsterCfgObj.getInstance().getMonsterCfg(_cfgId);
            showID = _loc_2.q_sculpt_resid;
            _attackspeed = _loc_2.q_attack_speed;
            q_weight = _loc_2.q_weight;
            _name = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11780"), [this._ownerName, _loc_2.q_name]);
            return;
        }// end function

        public function set monsterInfo(param1:CSMonsterInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _roleType = RoleType.ROLE_TYPE_MONSTER;
            _cfgId = param1.monsterModelId;
            _personId = param1.monsterId;
            _dir = param1.dir;
            _level = param1.level;
            _mapId = param1.mapId;
            _hp = param1.hp;
            _hpMax = param1.maxHp;
            _mp = param1.mp;
            _mpMax = param1.maxMp;
            _sp = param1.sp;
            _spMax = param1.maxSp;
            this._icon = param1.monsterIcon;
            _x = param1.x;
            _y = param1.y;
            _speed = param1.speed;
            direct = MapUtils.mapDirect2RoleDir(param1.dir);
            for each (_loc_2 in param1.buffs)
            {
                
                addBuff(_loc_2);
            }
            _loc_3 = MonsterCfgObj.getInstance().getMonsterCfg(_cfgId);
            showID = _loc_3.q_sculpt_resid;
            _attackspeed = _loc_3.q_attack_speed;
            q_weight = _loc_3.q_weight;
            _name = _loc_3.q_name;
            _q_gethit_type = _loc_3.q_gethit_type;
            _sculpt_zoom = _loc_3.q_sculpt_zoom;
            _monster_type = _loc_3.q_monster_type;
            _q_evasive_style = _loc_3.q_evasive_style;
            _q_mouse = _loc_3.q_mouse;
            headPic = Params.ROLE_HEAD_PATH + _loc_3.q_head_resid + ".png";
            this.friend = param1.friend;
            return;
        }// end function

    }
}
