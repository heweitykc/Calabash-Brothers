package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.utils.path.*;
    import com.game.equip.bean.*;
    import com.game.map.bean.*;
    import com.game.player.bean.*;
    import com.game.player.message.*;
    import com.game.team.bean.*;
    import com.game.utils.*;
    import com.staticdata.*;

    public class PlayerInfo extends RoleInfo
    {
        private var _fightState:uint = 1;
        private var _gm:int;
        private var _summonPetInfo:Vector.<MonsterInfo>;
        private var _createServerId:int;
        private var _loginType:int;
        private var _locate:int;
        private var _vitality:int;
        private var _strength:int;
        private var _agile:int;
        private var _intelligence:int;
        private var _unallocatedTalent:int;
        private var _ice_attack:int;
        private var _ray_attack:int;
        private var _poison_attack:int;
        private var _ice_def:int;
        private var _ray_def:int;
        private var _poison_def:int;
        private var _gnore_attackPercent:int;
        private var _hit:int;
        private var _hitPercent:int;
        private var _dodgePercent:int;
        private var _critPercent:int;
        private var _attackPercent:int;
        private var _physic_attackPercent:int;
        private var _magic_attackPercent:int;
        private var _Knowing_attackPercent:int;
        private var _physic_attackupper:int;
        private var _physic_attacklower:int;
        private var _magic_attackupper:int;
        private var _magic_attacklower:int;
        private var _ignore_attackPercent:int;
        private var _fatal_blow:int;
        private var _defensePercent:int;
        private var _q_hp_cover:int;
        private var _q_add_mplimit:int;
        private var _q_add_hplimit:int;
        private var _q_reduce_damage:int;
        private var _q_rebound_damage:int;
        private var _q_dodge:int;
        private var _q_add_money:int;
        private var _q_remarkable_attack:int;
        private var _q_physicattack_bylevel:int;
        private var _q_physicattack_percent:int;
        private var _q_magicattack_bylevel:int;
        private var _q_magicattack_percent:int;
        private var _q_attackspeed:int;
        private var _q_addhp_whenkill:int;
        private var _q_addmp_whenkill:int;
        private var _q_ignore_attackpercent:int;
        private var _know_attackpercent:int;
        private var _physic_attackpercent:int;
        private var _magic_attackpercent:int;
        private var _allattack_bylevel:int;
        private var _allattack_percent:int;
        private var _createTime:long;
        private var _teamId:long;
        private var _firstWeiduan:int;
        private var _offlineExp:int;
        private var _magicBook:MagicBookInfo;

        public function PlayerInfo()
        {
            _roleType = RoleType.ROLE_TYPE_PLAYER;
            return;
        }// end function

        public function get magicBook() : MagicBookInfo
        {
            return this._magicBook;
        }// end function

        public function set magicBook(param1:MagicBookInfo) : void
        {
            this._magicBook = param1;
            return;
        }// end function

        public function get allattack_percent() : int
        {
            return this._allattack_percent;
        }// end function

        public function set allattack_percent(param1:int) : void
        {
            this._allattack_percent = param1;
            return;
        }// end function

        public function get allattack_bylevel() : int
        {
            return this._allattack_bylevel;
        }// end function

        public function set allattack_bylevel(param1:int) : void
        {
            this._allattack_bylevel = param1;
            return;
        }// end function

        public function get gm() : int
        {
            return this._gm;
        }// end function

        public function set gm(param1:int) : void
        {
            this._gm = param1;
            return;
        }// end function

        public function get summonPetInfo() : Vector.<MonsterInfo>
        {
            return this._summonPetInfo;
        }// end function

        public function get teamId() : long
        {
            return this._teamId;
        }// end function

        public function set teamId(param1:long) : void
        {
            this._teamId = param1;
            return;
        }// end function

        public function get q_addmp_whenkill() : int
        {
            return this._q_addmp_whenkill;
        }// end function

        public function set q_addmp_whenkill(param1:int) : void
        {
            if (this._q_addmp_whenkill != param1)
            {
                this._q_addmp_whenkill = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ADDMP_WHENKILL));
            }
            return;
        }// end function

        public function get q_ignore_attackpercent() : int
        {
            return this._q_ignore_attackpercent;
        }// end function

        public function set q_ignore_attackpercent(param1:int) : void
        {
            this._q_ignore_attackpercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_IGNORE_ATTACKPERCENT));
            return;
        }// end function

        public function get physic_attackpercent() : int
        {
            return this._physic_attackpercent;
        }// end function

        public function set physic_attackpercent(param1:int) : void
        {
            this._physic_attackpercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PHYSIC_ATTACKPERCENT));
            return;
        }// end function

        public function get magic_attackpercent() : int
        {
            return this._magic_attackpercent;
        }// end function

        public function set magic_attackpercent(param1:int) : void
        {
            this._magic_attackpercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MAGIC_ATTACKPERCENT));
            return;
        }// end function

        public function get q_addhp_whenkill() : int
        {
            return this._q_addhp_whenkill;
        }// end function

        public function set q_addhp_whenkill(param1:int) : void
        {
            this._q_addhp_whenkill = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ADDHP_WHENKILL));
            return;
        }// end function

        public function get q_attackspeed() : int
        {
            return this._q_attackspeed;
        }// end function

        public function set q_attackspeed(param1:int) : void
        {
            this._q_attackspeed = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ATTACKSPEED));
            return;
        }// end function

        public function get q_magicattack_percent() : int
        {
            return this._q_magicattack_percent;
        }// end function

        public function set q_magicattack_percent(param1:int) : void
        {
            this._q_magicattack_percent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_MAGICATTACK_PERCENT));
            return;
        }// end function

        public function get q_magicattack_bylevel() : int
        {
            return this._q_magicattack_bylevel;
        }// end function

        public function set q_magicattack_bylevel(param1:int) : void
        {
            this._q_magicattack_bylevel = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_MAGICATTACK_BYLEVEL));
            return;
        }// end function

        public function get q_physicattack_percent() : int
        {
            return this._q_physicattack_percent;
        }// end function

        public function set q_physicattack_percent(param1:int) : void
        {
            this._q_physicattack_percent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_PHYSICATTACK_PERCENT));
            return;
        }// end function

        public function get q_physicattack_bylevel() : int
        {
            return this._q_physicattack_bylevel;
        }// end function

        public function set q_physicattack_bylevel(param1:int) : void
        {
            this._q_physicattack_bylevel = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDSATE_PHYSICATTACK_BYLEVEL));
            return;
        }// end function

        public function get q_remarkable_attack() : int
        {
            return this._q_remarkable_attack;
        }// end function

        public function set q_remarkable_attack(param1:int) : void
        {
            this._q_remarkable_attack = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_REMARKABLE_ATTACK));
            return;
        }// end function

        public function get q_add_money() : int
        {
            return this._q_add_money;
        }// end function

        public function set q_add_money(param1:int) : void
        {
            this._q_add_money = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ADD_MONEY));
            return;
        }// end function

        public function get q_dodge() : int
        {
            return this._q_dodge;
        }// end function

        public function set q_dodge(param1:int) : void
        {
            this._q_dodge = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_DODGE));
            return;
        }// end function

        public function get q_rebound_damage() : int
        {
            return this._q_rebound_damage;
        }// end function

        public function set q_rebound_damage(param1:int) : void
        {
            this._q_rebound_damage = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_REBOUND_DAMAGE));
            return;
        }// end function

        public function get q_reduce_damage() : int
        {
            return this._q_reduce_damage;
        }// end function

        public function set q_reduce_damage(param1:int) : void
        {
            this._q_reduce_damage = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_REDUCE_DAMAGE));
            return;
        }// end function

        public function get q_add_hplimit() : int
        {
            return this._q_add_hplimit;
        }// end function

        public function set q_add_hplimit(param1:int) : void
        {
            this._q_add_hplimit = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ADD_HPLIMIT));
            return;
        }// end function

        public function get q_add_mplimit() : int
        {
            return this._q_add_mplimit;
        }// end function

        public function set q_add_mplimit(param1:int) : void
        {
            this._q_add_mplimit = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_ADD_MPLIMIT));
            return;
        }// end function

        public function get q_hp_cover() : int
        {
            return this._q_hp_cover;
        }// end function

        public function set q_hp_cover(param1:int) : void
        {
            this._q_hp_cover = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_Q_HP_COVER));
            return;
        }// end function

        public function get defensePercent() : int
        {
            return this._defensePercent;
        }// end function

        public function set defensePercent(param1:int) : void
        {
            this._defensePercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DEFENSE_PERCENT));
            return;
        }// end function

        public function get ignore_attackPercent() : int
        {
            return this._ignore_attackPercent;
        }// end function

        public function set ignore_attackPercent(param1:int) : void
        {
            this._ignore_attackPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_IGNORE_ATTACKPERCENT));
            return;
        }// end function

        public function get magic_attacklower() : int
        {
            return this._magic_attacklower;
        }// end function

        public function set magic_attacklower(param1:int) : void
        {
            this._magic_attacklower = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MAGIC_ATTACKLOWER));
            return;
        }// end function

        public function get magic_attackupper() : int
        {
            return this._magic_attackupper;
        }// end function

        public function set magic_attackupper(param1:int) : void
        {
            this._magic_attackupper = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MAGIC_ATTACKUPPER));
            return;
        }// end function

        public function get physic_attacklower() : int
        {
            return this._physic_attacklower;
        }// end function

        public function set physic_attacklower(param1:int) : void
        {
            this._physic_attacklower = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PHYSIC_ATTACKLOWER));
            return;
        }// end function

        public function get physic_attackupper() : int
        {
            return this._physic_attackupper;
        }// end function

        public function set physic_attackupper(param1:int) : void
        {
            this._physic_attackupper = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PHYSIC_ATTACKUPPER));
            return;
        }// end function

        public function get Knowing_attackPercent() : int
        {
            return this._Knowing_attackPercent;
        }// end function

        public function set Knowing_attackPercent(param1:int) : void
        {
            this._Knowing_attackPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_KNOWING_ATTACKPERCENT));
            return;
        }// end function

        public function get magic_attackPercent() : int
        {
            return this._magic_attackPercent;
        }// end function

        public function set magic_attackPercent(param1:int) : void
        {
            this._magic_attackPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MAGIC_ATTACKPERCENT));
            return;
        }// end function

        public function get physic_attackPercent() : int
        {
            return this._physic_attackPercent;
        }// end function

        public function set physic_attackPercent(param1:int) : void
        {
            this._physic_attackPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PHYSIC_ATTACKPERCENT));
            return;
        }// end function

        public function get attackPercent() : int
        {
            return this._attackPercent;
        }// end function

        public function set attackPercent(param1:int) : void
        {
            this._attackPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_ATTACK_PERCENT));
            return;
        }// end function

        public function get critPercent() : int
        {
            return this._critPercent;
        }// end function

        public function set critPercent(param1:int) : void
        {
            this._critPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_CRIT_PERCENT));
            return;
        }// end function

        public function get dodgePercent() : int
        {
            return this._dodgePercent;
        }// end function

        public function set dodgePercent(param1:int) : void
        {
            this._dodgePercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DODGE_PERCENT));
            return;
        }// end function

        public function get hitPercent() : int
        {
            return this._hitPercent;
        }// end function

        public function set hitPercent(param1:int) : void
        {
            this._hitPercent = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_HIT_PERCENT));
            return;
        }// end function

        public function get hit() : int
        {
            return this._hit;
        }// end function

        public function set hit(param1:int) : void
        {
            this._hit = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_HIT));
            return;
        }// end function

        public function get poison_def() : int
        {
            return this._poison_def;
        }// end function

        public function set poison_def(param1:int) : void
        {
            this._poison_def = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_POISON_DEF));
            return;
        }// end function

        public function get ray_def() : int
        {
            return this._ray_def;
        }// end function

        public function set ray_def(param1:int) : void
        {
            this._ray_def = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_RAY_DEF));
            return;
        }// end function

        public function get ice_def() : int
        {
            return this._ice_def;
        }// end function

        public function set ice_def(param1:int) : void
        {
            this._ice_def = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_ICE_DEF));
            return;
        }// end function

        public function get fatal_blow() : int
        {
            return this._fatal_blow;
        }// end function

        public function set fatal_blow(param1:int) : void
        {
            this._fatal_blow = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_FATAL_BLOW));
            return;
        }// end function

        public function get poison_attack() : int
        {
            return this._poison_attack;
        }// end function

        public function set poison_attack(param1:int) : void
        {
            this._poison_attack = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_POISON_ATTACK));
            return;
        }// end function

        public function get ray_attack() : int
        {
            return this._ray_attack;
        }// end function

        public function set ray_attack(param1:int) : void
        {
            this._ray_attack = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_RAY_ATTACK));
            return;
        }// end function

        public function get ice_attack() : int
        {
            return this._ice_attack;
        }// end function

        public function set ice_attack(param1:int) : void
        {
            this._ice_attack = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_ICE_ATTACK));
            return;
        }// end function

        public function get strength() : int
        {
            return this._strength;
        }// end function

        public function set strength(param1:int) : void
        {
            this._strength = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_STRENGTH));
            return;
        }// end function

        public function get vitality() : int
        {
            return this._vitality;
        }// end function

        public function set vitality(param1:int) : void
        {
            this._vitality = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_VITALITY));
            return;
        }// end function

        public function get agile() : int
        {
            return this._agile;
        }// end function

        public function set agile(param1:int) : void
        {
            this._agile = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_AGILE));
            return;
        }// end function

        public function get intelligence() : int
        {
            return this._intelligence;
        }// end function

        public function set intelligence(param1:int) : void
        {
            this._intelligence = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_INTELLIGENCE));
            return;
        }// end function

        public function get unallocatedTalent() : int
        {
            return this._unallocatedTalent;
        }// end function

        public function set unallocatedTalent(param1:int) : void
        {
            var _loc_2:* = false;
            if (this._unallocatedTalent != param1)
            {
                _loc_2 = this._unallocatedTalent < param1;
                this._unallocatedTalent = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_UNALLOCALTEDTALENT, _loc_2));
            }
            return;
        }// end function

        public function set otherPlayerInfoMessage(param1:ResOtherPlayerInfoMessage) : void
        {
            var _loc_2:* = param1.attributes.length;
            _exp = param1.exp;
            this.level = param1.level;
            name = param1.name;
            job = param1.job;
            guildId = param1.guildID;
            artifact = param1.artifact;
            artifactRemold = param1.artifactRemold;
            if (param1.horseLev > 0)
            {
                horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(param1.horseLev, horseInfo);
            }
            else
            {
                horseInfo = null;
            }
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                setAttributte(param1.attributes[_loc_3]);
                _loc_3++;
            }
            if (param1.magicBookStar > 0)
            {
                this._magicBook = new MagicBookInfo();
                this._magicBook.level = param1.magicBookLevel;
            }
            else
            {
                this._magicBook = null;
            }
            return;
        }// end function

        public function set playerInfo(param1:CSPlayerInfo) : void
        {
            _personId = param1.personId;
            _avatar = param1.avatar;
            _hiddenweaponid = param1.hiddenweaponid;
            _equipPetId = param1.equipPetId;
            if (param1.horseid > 0)
            {
                _horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(param1.horseid);
                if (_horseInfo)
                {
                    _horseInfo.horseStat = 1;
                }
            }
            else
            {
                _horseInfo = null;
            }
            guildId = param1.guild;
            pkValue = param1.pkValue;
            guildName = param1.guildName;
            initBuffs(param1.buffs);
            _horseweaponid = param1.horseweaponid;
            _level = param1.level;
            _mapId = param1.mapId;
            _name = param1.name;
            _webvip = param1.webvip;
            if (param1.weapon > 0)
            {
                _weapon = ItemCfgObj.getInstance().getItemCfg(param1.weapon);
                if (_weapon)
                {
                    _weapon.streng = param1.weaponStreng;
                }
            }
            else
            {
                _weapon = null;
            }
            if (param1.weapon_other > 0)
            {
                _weapon_other = ItemCfgObj.getInstance().getItemCfg(param1.weapon_other);
                if (_weapon_other)
                {
                    _weapon_other.streng = param1.weaponStreng_other;
                }
            }
            else
            {
                _weapon_other = null;
            }
            if (param1.state == 32)
            {
                actType = Params.ACTION_DEAD;
            }
            if (param1.wing > 0)
            {
                _wingInfo = ItemCfgObj.getInstance().getItemCfg(param1.wing);
                _wingInfo.streng = param1.wingStreng;
            }
            else
            {
                _wingInfo = null;
            }
            _x = param1.x;
            _y = param1.y;
            job = param1.job;
            HP = param1.hp;
            MP = param1.mp;
            SP = param1.sp;
            HPMax = param1.maxHp;
            MPMax = param1.maxMp;
            SPMax = param1.maxSp;
            speed = param1.speed;
            maxExp = LevelExpCfgObj.getInstance().getExpByLevel(job, _level);
            topTitleId = param1.toptitleid;
            suitEffectCount = param1.suitEffectCount;
            suitEffectIds = param1.suitEffectIds;
            param1.suitEffectIds = null;
            _dir = param1.dir;
            direct = MapUtils.mapDirect2RoleDir(param1.dir);
            if (param1.armor > 0)
            {
                armor = ItemCfgObj.getInstance().getItemCfg(param1.armor);
                if (armor)
                {
                    armor.streng = param1.armorStreng;
                }
            }
            else
            {
                armor = null;
            }
            _allStrength = param1.allStrength;
            _attackspeed = param1.attackspeed;
            _csysKills = param1.csysKills;
            if (param1.magicBookStar > 0)
            {
                this._magicBook = new MagicBookInfo();
                this._magicBook.level = param1.magicBookLevel;
            }
            else
            {
                this._magicBook = null;
            }
            return;
        }// end function

        public function isGM() : Boolean
        {
            return this._gm > 0;
        }// end function

        public function hasSummonPetType(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._summonPetInfo)
            {
                _loc_2 = 0;
                _loc_3 = this._summonPetInfo.length;
                while (_loc_2 < _loc_3)
                {
                    
                    if (this._summonPetInfo[_loc_2].cfgId == param1)
                    {
                        return true;
                    }
                    _loc_2++;
                }
            }
            return false;
        }// end function

        public function getSummonPetTypeNum() : int
        {
            if (this._summonPetInfo)
            {
                return this._summonPetInfo.length;
            }
            return 0;
        }// end function

        public function addSummonPetInfo(param1:MonsterInfo) : void
        {
            if (!this._summonPetInfo)
            {
                this._summonPetInfo = new Vector.<MonsterInfo>;
            }
            var _loc_2:* = 0;
            var _loc_3:* = this._summonPetInfo.length;
            var _loc_4:* = false;
            while (_loc_2 < _loc_3)
            {
                
                if (this._summonPetInfo[_loc_2].personId.equal(param1.personId))
                {
                    _loc_4 = true;
                    break;
                }
                _loc_2++;
            }
            if (!_loc_4)
            {
                this._summonPetInfo.push(param1);
            }
            return;
        }// end function

        public function removeSummonPetInfo(param1:long) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._summonPetInfo)
            {
                _loc_2 = 0;
                _loc_3 = this._summonPetInfo.length;
                while (_loc_2 < _loc_3)
                {
                    
                    if (this._summonPetInfo[_loc_2].personId.equal(param1))
                    {
                        this._summonPetInfo.splice(_loc_2, 1);
                        return true;
                    }
                    _loc_2++;
                }
            }
            return false;
        }// end function

        public function set myPlayerInfo(param1:ResMyPlayerInfoMessage) : void
        {
            var _loc_2:* = null;
            this._gm = param1.gm;
            _personId = param1.personId;
            _avatar = param1.avatar;
            _bindgold = param1.bindgold;
            _cellnum = param1.cellnum;
            _dir = param1.dir;
            _pkState = param1.pkState;
            guildId = param1.guild;
            pkValue = param1.pkValue;
            enemies = param1.enemies;
            topTitleId = param1.topTitleId;
            if (guildId && guildId.equal(new long(0, 0)))
            {
                guildId = null;
            }
            guildName = param1.guildName;
            _exp = param1.exp;
            _money = param1.money;
            _gold = param1.gold;
            _hiddenweaponid = param1.hiddenweaponid;
            if (param1.horseid > 0)
            {
                _horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(param1.horseid, _horseInfo);
            }
            else
            {
                _horseInfo = null;
            }
            _dir = param1.dir;
            direct = MapUtils.mapDirect2RoleDir(param1.dir);
            _vipid = param1.vipid;
            _horseweaponid = param1.horseweaponid;
            job = param1.job;
            if (param1.level > Params.ROLE_MAX_LEVEL)
            {
                headPic = Params.ROLE_HEAD_PATH + "job" + ((_job - 1) % 3 + 1) + "-4.png";
            }
            else
            {
                headPic = Params.ROLE_HEAD_PATH + "job" + ((_job - 1) % 3 + 1) + ".png";
            }
            _kingcitybuffid = param1.kingcitybuffid;
            _level = param1.level;
            _longyuanlv = param1.longyuanlv;
            _longyuannum = param1.longyuannum;
            _maintaskId = param1.maintaskId;
            _mapId = param1.mapId;
            _name = param1.name;
            _zhenqi = param1.zhenqi;
            _webvip = param1.webvip;
            _webvip2 = param1.webvip2;
            _skills = param1.skills;
            _skill = param1.skill;
            _prestige = param1.prestige;
            this._strength = param1.power;
            this._vitality = param1.strength;
            this._agile = param1.agile;
            this._intelligence = param1.wit;
            this._unallocatedTalent = param1.reserved;
            this._ice_attack = param1.ice_attack;
            this._poison_attack = param1.poison_attack;
            this._ray_attack = param1.ray_attack;
            this._ice_def = param1.ice_def;
            this._poison_def = param1.poison_def;
            this._ray_def = param1.ray_def;
            this._ignore_attackPercent = param1.ignore_attackPercent;
            this._hit = param1.hit;
            _dodge = param1.dodge;
            this._hitPercent = param1.hitPercent;
            this._dodgePercent = param1.dodgePercent;
            _crit = param1.crit;
            this._critPercent = param1.critPercent;
            this._Knowing_attackPercent = param1.Knowing_attackPercent;
            _attack = param1.attack;
            this._fatal_blow = param1.fatal_blow;
            this._physic_attacklower = param1.physic_attacklower;
            this._physic_attackupper = param1.physic_attackupper;
            this._physic_attackPercent = param1.physic_attackPercent;
            this._attackPercent = param1.attackPercent;
            this._magic_attacklower = param1.magic_attacklower;
            this._magic_attackupper = param1.magic_attackupper;
            this._magic_attackPercent = param1.magic_attackPercent;
            _defense = param1.defense;
            this._defensePercent = param1.defensePercent;
            this._teamId = param1.teamId;
            this._createTime = param1.createTime;
            _spirit = param1.spirit;
            maxExp = LevelExpCfgObj.getInstance().getExpByLevel(_job, _level);
            _x = param1.x;
            _y = param1.y;
            _equipPetId = param1.equips[(Params.PET - 1)].itemModelId;
            this._initPlayerViewByEquipInfo(param1.equips);
            for each (_loc_2 in param1.attributes)
            {
                
                setAttributte(_loc_2);
            }
            this._firstWeiduan = param1.firstWeiDuan;
            suitEffectCount = param1.suitEffectCount;
            suitEffectIds = param1.suitEffectIds;
            param1.suitEffectIds = null;
            if (param1.magicBookStar > 0)
            {
                this._magicBook = new MagicBookInfo();
                this._magicBook.level = param1.magicBookLevel;
            }
            else
            {
                this._magicBook = null;
            }
            dispatchEvent(new RoleEvent(RoleEvent.SET_MY_INFO));
            return;
        }// end function

        public function setTeamInfo(param1:TeamMemberInfo) : void
        {
            _personId = param1.memberid;
            _avatar = param1.appearanceInfo.avatarid;
            if (param1.appearanceInfo.weaponmodid > 0)
            {
                _weapon = ItemCfgObj.getInstance().getItemCfg(param1.appearanceInfo.weaponmodid);
            }
            _horseweaponid = param1.appearanceInfo.horsemodid;
            _sex = param1.appearanceInfo.sex;
            job = param1.memberJob < 1 ? (1) : (param1.memberJob);
            var _loc_2:* = PlayerCfgObj.getInstance().getPriObjByJob(_job);
            showID = _loc_2.model_resourse;
            this._initPlayerViewByEquipInfo(param1.appearanceInfo.equips);
            return;
        }// end function

        public function setByTopListInfo(param1:TopListInfo) : void
        {
            _personId = param1.playerid;
            _avatar = param1.avatar;
            _sex = param1.sex;
            _vipid = param1.vipid;
            job = param1.job;
            name = param1.playername;
            _exp = param1.exp;
            _level = param1.level;
            this._initPlayerViewByEquipInfo(param1.itemlist);
            return;
        }// end function

        private function _initPlayerViewByEquipInfo(param1:Vector.<EquipInfo>) : void
        {
            var _loc_2:* = null;
            if (param1 && param1.length > 0)
            {
                _loc_2 = param1[(Params.LEFT_WEAPON - 1)];
                if (_loc_2 && _loc_2.itemModelId > 0)
                {
                    _weapon = ItemCfgObj.getInstance().getItemCfg(_loc_2.itemModelId);
                    if (_weapon)
                    {
                        _weapon.streng = _loc_2.itemLevel;
                    }
                }
                else
                {
                    _weapon = null;
                }
                _loc_2 = param1[(Params.RIGHT_WEAPON - 1)];
                if (_loc_2 && _loc_2.itemModelId > 0)
                {
                    _weapon_other = ItemCfgObj.getInstance().getItemCfg(_loc_2.itemModelId);
                    if (_weapon_other)
                    {
                        _weapon_other.streng = _loc_2.itemLevel;
                    }
                }
                else
                {
                    _weapon_other = null;
                }
                _loc_2 = param1[(Params.BODY - 1)];
                if (_loc_2 && _loc_2.itemModelId > 0)
                {
                    armor = ItemCfgObj.getInstance().getItemCfg(_loc_2.itemModelId);
                    if (armor)
                    {
                        armor.streng = _loc_2.itemLevel;
                    }
                }
                else
                {
                    armor = null;
                }
                _loc_2 = param1[(Params.WING - 1)];
                if (_loc_2 && _loc_2.itemModelId > 0)
                {
                    wingInfo = ItemCfgObj.getInstance().getItemCfg(_loc_2.itemModelId);
                    if (wingInfo)
                    {
                        wingInfo.streng = _loc_2.itemLevel;
                    }
                }
                else
                {
                    wingInfo = null;
                }
                this.countEquip11_13(param1);
            }
            return;
        }// end function

        private function countEquip11_13(param1:Vector.<EquipInfo>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_4:* = [0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0];
            var _loc_5:* = param1.length;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_5)
            {
                
                _loc_7 = param1[_loc_8];
                _loc_6 = _loc_7.itemLevel;
                if (!_loc_4[_loc_8])
                {
                    _loc_3 = _loc_3 + 1;
                    _loc_2 = _loc_2 + 1;
                }
                else if (_loc_6 >= 13)
                {
                    _loc_3 = _loc_3 + 1;
                }
                else if (_loc_6 >= 11)
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_8 = _loc_8 + 1;
            }
            if (_loc_3 >= _loc_5)
            {
                _allStrength = 13;
            }
            else if (_loc_2 >= _loc_5)
            {
                _allStrength = 11;
            }
            else
            {
                _allStrength = 0;
            }
            return;
        }// end function

        public function get fightState() : uint
        {
            return this._fightState;
        }// end function

        public function set fightState(param1:uint) : void
        {
            this._fightState = param1;
            return;
        }// end function

        public function get createTime() : long
        {
            return this._createTime;
        }// end function

        public function set createTime(param1:long) : void
        {
            this._createTime = param1;
            return;
        }// end function

        public function getJob() : int
        {
            return 0;
        }// end function

        public function get firstWeiduan() : int
        {
            return this._firstWeiduan;
        }// end function

        public function get offlineExp() : int
        {
            return this._offlineExp;
        }// end function

        public function set offlineExp(param1:int) : void
        {
            this._offlineExp = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_OFFLINE_EXP));
            return;
        }// end function

        override public function set level(param1:int) : void
        {
            if (param1 > Params.ROLE_MAX_LEVEL)
            {
                headPic = Params.ROLE_HEAD_PATH + "job" + ((_job - 1) % 3 + 1) + "-4.png";
            }
            else
            {
                headPic = Params.ROLE_HEAD_PATH + "job" + ((_job - 1) % 3 + 1) + ".png";
            }
            super.level = param1;
            return;
        }// end function

    }
}
