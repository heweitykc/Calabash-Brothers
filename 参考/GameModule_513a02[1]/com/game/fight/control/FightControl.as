package com.game.fight.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.keyboard.*;
    import com.f1.ui.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.f1.utils.path.*;
    import com.game.autopk.*;
    import com.game.buff.control.*;
    import com.game.fight.bean.*;
    import com.game.fight.control.specialskill.*;
    import com.game.fight.message.*;
    import com.game.fight.model.*;
    import com.game.fight.protocol.*;
    import com.game.fight.view.*;
    import com.game.magicbook.control.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.player.message.*;
    import com.game.prompt.control.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.shop.control.*;
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import com.game.structs.*;
    import com.game.task.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class FightControl extends Object
    {
        private var _skillShowControl:SkillShowControl;
        private var blood_num:ImgNumber;
        private var pkLev:int;
        private var attacklev:int;
        private var pkTips1:String;
        private var pkTips2:String;
        private var pkTips3:String;
        private var _roleList:RoleList;
        private var _protocol:FightProtocol;
        private var _currentGameScene:GameScene;
        private var _lockedMounsterId:long;
        private var _skillCount:int;
        private const MAX_COUNT:uint = 5;
        private var _beginHp:int;
        private var damageSum:int = 0;
        private var lastTime:Number = 0;
        private var nowTime:int = 0;
        private var attactList:Vector.<long>;
        private var shanDianLianControl:ShanDianLianControl;
        private var iconCombo:SkillComboIcon;
        private static var instance:FightControl;

        public function FightControl()
        {
            this._roleList = RoleList.getInstance();
            this._protocol = new FightProtocol();
            this._skillShowControl = new SkillShowControl();
            this.pkLev = GlobalCfgObj.getInstance().getPKlowestLevel();
            this.attacklev = GlobalCfgObj.getInstance().getAttackDifLevel();
            this.pkTips1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12044"), [this.pkLev]);
            this.pkTips2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12045"), [this.pkLev]);
            this.pkTips3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12046"), [this.attacklev]);
            KeyboardManager.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDown);
            return;
        }// end function

        public function set currentGameScene(param1:GameScene) : void
        {
            var _loc_2:* = param1;
            this._currentGameScene = param1;
            this._skillShowControl.currentGameScene = _loc_2;
            MagicBookSkillShowControl.getInstance().currentGameScene = this._currentGameScene;
            return;
        }// end function

        private function __keyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.ESCAPE)
            {
                this.delCurrentSkill();
            }
            return;
        }// end function

        public function addSkillCD(param1:Skill) : void
        {
            CDManager.getInstance().addCD(CDTypes.SKILL, param1.q_cd, param1.q_cd, param1.q_skillID, param1.q_public_cd, param1.q_public_cd_level);
            return;
        }// end function

        public function setSkillCD(param1:Skill, param2:int) : void
        {
            CDManager.getInstance().addCD(CDTypes.SKILL, param2, param1.q_cd, param1.q_skillID, param1.q_public_cd, param1.q_public_cd_level);
            return;
        }// end function

        public function resetAllSkill(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.skillList;
            var _loc_3:* = _loc_2 ? (_loc_2.length) : (0);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                this.setSkillCD(_loc_5, param1);
                _loc_4++;
            }
            return;
        }// end function

        public function checkCD(param1:Skill) : Boolean
        {
            return CDManager.getInstance().isInCD(CDTypes.SKILL, param1.q_skillID, param1.q_public_cd_level);
        }// end function

        public function checkBuff() : Boolean
        {
            return BuffControl.getInstance().restrictSkill;
        }// end function

        public function useSkill(param1:uint, param2:IRole = null, param3:uint = 0, param4:uint = 0) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_5:* = RoleList.getInstance().player;
            if (!RoleList.getInstance().player || !_loc_5.alive())
            {
                return;
            }
            var _loc_6:* = SkillCfgObj.getInstance().getSkillInfoById(param1);
            if (!SkillCfgObj.getInstance().getSkillInfoById(param1))
            {
                return;
            }
            _loc_6.targetX = param3;
            _loc_6.targetY = param4;
            _loc_6.targetRole = param2;
            if (param2 && param2.info && _loc_6.q_pointtype > 0 && _loc_6.q_skill_type != 7)
            {
                _loc_7 = new Array();
                _loc_7 = _loc_7.concat(param2.info.getBuffsByActType(BuffType.INVINCIBLE));
                _loc_7 = _loc_7.concat(param2.info.getBuffsByActType(BuffType.PKPROTECT));
                _loc_7 = _loc_7.concat(param2.info.getBuffsByActType(BuffType.PROTECTFORNIGHT));
                if (_loc_7.length > 0)
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10683"));
                    return;
                }
            }
            if (param1 == SpecialSkillID.SKILL_SHUN_YI)
            {
                param2 = _loc_5;
            }
            if (_loc_6.isAreaTargetSelf() || _loc_6.isTargetSelf())
            {
                if (!param2 && _loc_6.isPointRole())
                {
                    param2 = RoleList.getInstance().selectNearestRole(_loc_5);
                }
                if (param2)
                {
                    _loc_6.targetX = param2._x;
                    _loc_6.targetY = param2._y;
                    MapControl.getInstance().currentGameScene.showSelectRole(param2);
                }
                else if (_loc_6.isShapeCircle())
                {
                }
                else
                {
                    _loc_6.targetX = FrameworkGlobal.stage.mouseX - this._currentGameScene.bgView.x;
                    _loc_6.targetY = FrameworkGlobal.stage.mouseY - this._currentGameScene.bgView.y;
                }
                _loc_8 = _loc_6.q_brief_skill_type.substr(0, 3);
                if (_loc_8 == "400")
                {
                    if (param2 == null)
                    {
                        param2 = RoleList.getInstance().selectNearestRole(_loc_5);
                    }
                    _loc_6.targetRole = param2;
                }
                else if (_loc_6.q_brief_skill_type == "300001" || _loc_6.q_brief_skill_type == "200001" && param2 && param2.isFriend())
                {
                    _loc_6.targetRole = param2;
                }
                else
                {
                    _loc_6.targetRole = _loc_5;
                }
            }
            else if (_loc_6.isTargetFriend())
            {
                if (!param2)
                {
                    if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.isFriend())
                    {
                        param2 = UserObj.getInstance().selectRole as IRole;
                    }
                }
                if (param2 && param2.isFriend())
                {
                    _loc_6.targetX = param2._x;
                    _loc_6.targetY = param2._y;
                    _loc_6.targetRole = param2;
                }
                else
                {
                    _loc_6.targetX = _loc_5._x;
                    _loc_6.targetY = _loc_5._y;
                    _loc_6.targetRole = _loc_5;
                }
            }
            else if (param3 == 0 && param4 == 0)
            {
                if (!param2)
                {
                    if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.isMonster())
                    {
                        param2 = UserObj.getInstance().selectRole as IRole;
                    }
                    else
                    {
                        param2 = RoleList.getInstance().selectNearestRole(_loc_5);
                        if (param2)
                        {
                            UserObj.getInstance().selectRole = param2;
                        }
                    }
                }
                if (param2)
                {
                    _loc_6.targetX = param2._x;
                    _loc_6.targetY = param2._y;
                    _loc_6.targetRole = param2;
                }
                else
                {
                    this.delCurrentSkill();
                    return;
                }
            }
            UserObj.getInstance().playerInfo.currentSkill = _loc_6;
            return;
        }// end function

        public function checkAndAttack(param1:IRole) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_2:* = param1.info.currentSkill;
            if (!_loc_2)
            {
                return;
            }
            if (param1.isPlayer() && Player(param1).isStun())
            {
                return;
            }
            if (_loc_2.q_skillID == SpecialSkillID.SKILL_SHUN_YI)
            {
                _loc_7 = param1;
            }
            var _loc_3:* = _loc_2.targetRole;
            if (_loc_3 && !_loc_3.isMonster() && _loc_2.q_target == 3)
            {
                if (MapObj.getInstance().isSafe(MapUtils.coo2Tile(_loc_7._x), MapUtils.coo2Tile(_loc_7._y)))
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10684"));
                    _loc_7.info.currentSkill.targetRole = null;
                    FightControl.getInstance().delCurrentSkill();
                    return;
                }
                if (MapObj.getInstance().isSafe(MapUtils.coo2Tile(_loc_3._x), MapUtils.coo2Tile(_loc_3._y)))
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10685"));
                    _loc_7.info.currentSkill.targetRole = null;
                    FightControl.getInstance().delCurrentSkill();
                    return;
                }
            }
            if (_loc_7.isZonesMorph && (_loc_2.q_skillID == 10007 || _loc_2.q_skillID == 10016 || _loc_2.q_skillID == 10023))
            {
                this.delCurrentSkill();
                return;
            }
            if (this.checkCD(_loc_2))
            {
                return;
            }
            if (this.checkBuff())
            {
                if (BuffControl.getInstance().lockSKill)
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("FightControl_1409727905"));
                }
                return;
            }
            if (!this.checkTarget(_loc_2, param1))
            {
                this.delCurrentSkill();
                return;
            }
            if (!this.checkCondition(_loc_7.info, _loc_2))
            {
                return;
            }
            if (UserObj.getInstance().playerInfo.isBecome)
            {
                _loc_8 = UserObj.getInstance().playerInfo.getBecomeBuffSkillId();
                if (_loc_2.q_skillID == _loc_8)
                {
                    this.addSkillCD(_loc_2);
                    this._protocol.attackPosition(_loc_2.q_skillID, _loc_7._x, _loc_7._y, _loc_6, MapObj.getInstance().mapID, UserObj.getInstance().line);
                    return;
                }
            }
            _loc_6 = MapUtils.DIRECT_90;
            _loc_7 = _loc_2.targetRole;
            if (_loc_7)
            {
                MapControl.getInstance().currentGameScene.showSelectRole(_loc_7);
                if (!_loc_2.isTargetMouse())
                {
                    _loc_2.targetX = _loc_7._x;
                    _loc_2.targetY = _loc_7._y;
                }
            }
            if (_loc_7 && _loc_7 != param1 && _loc_7.isPlayer())
            {
                if (_loc_2.q_skillID == SpecialSkillID.HEI_LONG_BO || _loc_2.q_skillID == SpecialSkillID.PILI_HUIXUAN_ZHAN || _loc_2.q_skillID == SpecialSkillID.WU_CHONG_JIAN)
                {
                    PromptControl.getInstance().personNoticeClient("dante_pk_limitPVEskill");
                    this.delCurrentSkill();
                    return;
                }
            }
            if (_loc_7 && _loc_7 != param1)
            {
                if (!_loc_7.alive())
                {
                    this.delCurrentSkill();
                    return;
                }
                _loc_4 = _loc_3._x;
                _loc_5 = _loc_3._y;
                _loc_9 = ToolKit.distance(param1._x, param1._y, _loc_4, _loc_5);
                if (_loc_9 > 0)
                {
                    if (_loc_9 > _loc_2.q_range_limit * MapUtils.GRID_BORDER)
                    {
                        if (param1.pathByCoo(_loc_4, _loc_5, 0, 0, false, false) == false)
                        {
                            this.delCurrentSkill();
                        }
                        else
                        {
                            Player.state = State.NONE;
                        }
                        return;
                    }
                }
                _loc_6 = param1.face2(_loc_4, _loc_5);
            }
            else if (_loc_2.q_skillID == SpecialSkillID.SKILL_SHUN_YI)
            {
                _loc_4 = FrameworkGlobal.stage.mouseX - this._currentGameScene.bgView.x;
                _loc_5 = FrameworkGlobal.stage.mouseY - this._currentGameScene.bgView.y;
                _loc_6 = param1.face2(_loc_4, _loc_5);
            }
            else
            {
                _loc_4 = _loc_2.targetX;
                _loc_5 = _loc_2.targetY;
                if (_loc_4 != 0 || _loc_5 != 0)
                {
                    _loc_6 = param1.face2(_loc_4, _loc_5);
                }
            }
            if (param1.isUser() && param1.isPathing)
            {
                MapControl.getInstance().stopPath(param1);
            }
            if (_loc_2.q_skill_type == SpecialSkillID.CHONG_FENG_TYPE)
            {
                param1.stopWhenRelease = true;
            }
            else if (_loc_2.q_skill_type == SpecialSkillID.DI_LIE_ZHAN)
            {
                param1.stopWhenRelease = true;
            }
            param1.attack();
            if (_loc_2.q_skill_type != 1)
            {
                this._skillShowControl.showRelease(param1, _loc_2);
            }
            this.addSkillCD(_loc_2);
            if (_loc_2.q_area_shape == SkillInfo.SHAPE_USER)
            {
                _loc_10 = new HeiLongBoControl();
                _loc_11 = _loc_10.checkAttackRole(_loc_2, param1);
                this._protocol.attackSpecial(_loc_2.q_skillID, param1._x, param1._y, _loc_6, MapObj.getInstance().mapID, UserObj.getInstance().line, _loc_11);
            }
            else if (_loc_7)
            {
                if (_loc_2.isTargetFriend() || _loc_2.isTargetSelf())
                {
                    this._protocol.attackFriend(_loc_2.q_skillID, _loc_7.info.personId, _loc_7.info.roleType, _loc_6);
                    this.delCurrentSkill();
                }
                else if (_loc_7.isMonster())
                {
                    this._protocol.attackMonster(_loc_2.q_skillID, _loc_7.info.personId, _loc_6);
                }
                else if (_loc_7.isSummonPet())
                {
                    this._protocol.attackSummonPet(_loc_2.q_skillID, _loc_7.info.personId, _loc_6, _loc_7.info.owner);
                }
                else if (_loc_7.isUser())
                {
                    if (_loc_2.isAreaTargetSelf() && _loc_2.q_skillID != SpecialSkillID.SKILL_SHUN_YI)
                    {
                        this._protocol.attackPosition(_loc_2.q_skillID, param1._x, param1._y, _loc_6, MapObj.getInstance().mapID, UserObj.getInstance().line);
                    }
                    else
                    {
                        this._protocol.attackPosition(_loc_2.q_skillID, _loc_4, _loc_5, _loc_6, MapObj.getInstance().mapID, UserObj.getInstance().line);
                    }
                    this.delCurrentSkill();
                }
                else if (_loc_7.isPlayer())
                {
                    this._protocol.attackPlayer(_loc_2.q_skillID, _loc_7.info.personId, _loc_6);
                }
                else if (_loc_7.isClientMonster())
                {
                    _loc_12 = SkillCfgObj.getInstance().getSkillDamageObjById(_loc_2.q_skillID);
                    if (_loc_12)
                    {
                        _loc_13 = int(_loc_12.q_damage) + (int(_loc_12.q_scene) + MapClientControl.getInstance().HIT_RANGE_PLUS) * (1 - Math.random() * 2) + MapClientControl.getInstance().HIT_PLUS;
                    }
                    else
                    {
                        _loc_13 = 100;
                    }
                    if (_loc_7.info.HP < _loc_13)
                    {
                        _loc_13 = _loc_7.info.HP;
                    }
                    if (_loc_7.info.HP <= _loc_13 && _loc_7.info.cfgId == ClientZonesSkeletonKingControl.getInstance().BOSS_MODEL_ID)
                    {
                        ClientZonesSkeletonKingControl.getInstance().lastAttack();
                    }
                    ClientMonster(_loc_7).moveToAttack(param1);
                    MapClientControl.getInstance().createAttackResult(_loc_2.q_skillID, param1.info.personId, _loc_7.info.personId, _loc_13, _loc_7.info.HP - _loc_13);
                }
            }
            if (!_loc_2.q_loopmagic)
            {
                this.delCurrentSkill();
                if (_loc_2.hasTargetRole() && _loc_3.isEnemy() && _loc_3.alive() && AutoFightManager.getInstance().type == AutoFightManager.NONE_TYPE)
                {
                    this.useSkill(UserObj.getInstance().playerInfo.defaultSkillId, UserObj.getInstance().selectRole);
                }
            }
            return;
        }// end function

        public function checkCondition(param1:RoleInfo, param2:Skill) : Boolean
        {
            if (!param1)
            {
                Log.log("角色不存在");
                return false;
            }
            if (param1.MP < param2.q_need_mp)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10686"));
                this.delCurrentSkill();
                return false;
            }
            return true;
        }// end function

        public function checkTarget(param1:SkillInfo, param2:IRole) : Boolean
        {
            var _loc_4:* = 0;
            if (param1.isPointRole())
            {
                if (!param1.targetRole)
                {
                    return false;
                }
            }
            var _loc_3:* = param1.targetRole;
            if (_loc_3)
            {
                if (param1.q_skill_type == SkillInfo.SKILL_TYPE_ADD)
                {
                    return true;
                }
                if (param1.isTargetFriend())
                {
                    if (!_loc_3.isFriend())
                    {
                        return false;
                    }
                }
                else if (!_loc_3.isUser() && _loc_3.isFriend())
                {
                    if (_loc_3.isSummonPet())
                    {
                        _loc_3 = RoleList.getInstance().getRole(_loc_3.info.owner);
                    }
                    if (param2.isUser() && _loc_3.isPlayer() && !_loc_3.isUser() && param1.q_target != 2)
                    {
                        if (MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID).q_map_pk == 0)
                        {
                            return true;
                        }
                        if (param2.info.level < this.pkLev)
                        {
                            Global.popManager.addedToSystem(this.pkTips1);
                            return false;
                        }
                        if (_loc_3.info.level < this.pkLev)
                        {
                            Global.popManager.addedToSystem(this.pkTips2);
                            return false;
                        }
                        if (Math.abs(param2.info.level - _loc_3.info.level) > this.attacklev)
                        {
                            Global.popManager.addedToSystem(this.pkTips3);
                            return false;
                        }
                    }
                    if (!_loc_3.isUser())
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10687"));
                    }
                    return false;
                }
                _loc_4 = MapObj.getInstance().mapID;
                if (_loc_4 == Params.COUNTRY_MAP_ID)
                {
                    return true;
                }
                if (MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID).q_map_pk == 0)
                {
                    return true;
                }
                if (MapCfgObj.getInstance().getMap(_loc_4).q_map_safe == 1 && !_loc_3.isUser() && !_loc_3.isMonster() && !_loc_3.isClientMonster())
                {
                    return false;
                }
                if (UserObj.getInstance().playerInfo.pkValue >= 10 && param2 && param2.info && _loc_3.info && !param2.info.personId.equal(_loc_3.info.personId) && _loc_3.isPlayer() && param1.q_target != 0)
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10688"));
                    return false;
                }
                if (_loc_3.isSummonPet())
                {
                    _loc_3 = RoleList.getInstance().getRole(_loc_3.info.owner);
                }
                if (param2.isUser() && _loc_3.isPlayer() && !_loc_3.isUser() && param1.q_target != 2)
                {
                    if (MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID).q_map_pk == 0)
                    {
                        return true;
                    }
                    if (param2.info.level < this.pkLev)
                    {
                        Global.popManager.addedToSystem(this.pkTips1);
                        return false;
                    }
                    if (_loc_3.info.level < this.pkLev)
                    {
                        Global.popManager.addedToSystem(this.pkTips2);
                        return false;
                    }
                    if (Math.abs(param2.info.level - _loc_3.info.level) > this.attacklev)
                    {
                        Global.popManager.addedToSystem(this.pkTips3);
                        return false;
                    }
                }
            }
            return true;
        }// end function

        public function delCurrentSkill() : void
        {
            if (UserObj.getInstance().playerInfo.currentSkill && UserObj.getInstance().playerInfo.currentSkill.q_skillID == 10013)
            {
            }
            UserObj.getInstance().playerInfo.currentSkill = null;
            return;
        }// end function

        public function showSkillRelease(param1:IRole, param2:SkillInfo) : void
        {
            if (this._skillShowControl)
            {
                this._skillShowControl.showRelease(param1, param2);
            }
            return;
        }// end function

        public function attackResultHandler(param1:ResAttackResultMessage) : void
        {
            var _loc_6:* = null;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = false;
            this.attactList = param1.fighterIds;
            var _loc_2:* = param1.state;
            if (_loc_2.skillId == 0)
            {
                _loc_2.skillId = 10001;
            }
            var _loc_3:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_2.skillId);
            if (_loc_2.skillId == SpecialSkillID.SKILL_SHAN_DIAN_LIE)
            {
                if (!this.shanDianLianControl)
                {
                    this.shanDianLianControl = new ShanDianLianControl(this._skillShowControl);
                }
                this.shanDianLianControl.attackResult(param1);
                return;
            }
            var _loc_4:* = this._roleList.getRole(_loc_2.sourceId);
            if (!this._roleList.getRole(_loc_2.sourceId) || !_loc_4.info)
            {
                Log.log("攻击者不存在，或者已经死亡");
                return;
            }
            var _loc_5:* = _loc_2.fightResult;
            var _loc_7:* = -_loc_2.damage;
            var _loc_8:* = this._roleList.getRole(_loc_2.entityId);
            if (!_loc_4.isUser() && _loc_8 && _loc_8.isUser())
            {
                RoleList.getInstance().hateRecord(param1.state);
            }
            if (_loc_8 && _loc_8.info)
            {
                if ((_loc_8.isMonster() || _loc_8.isClientMonster()) && _loc_4.isUser() && !_loc_8.isPathing)
                {
                    if (!_loc_8.info.q_gethit_type)
                    {
                        _loc_8.face2(_loc_4._x, _loc_4._y);
                    }
                }
                _loc_9 = _loc_4.isUser() || _loc_8.isUser();
                if (_loc_2.damage > 0)
                {
                    if (_loc_8.isMonster() || _loc_8.isClientMonster())
                    {
                        _loc_10 = MapUtils.countDirection(_loc_4._x, _loc_4._y, _loc_8._x, _loc_8._y);
                        if (_loc_3 && _loc_3.q_blood_num && _loc_3.q_blood_num > 1)
                        {
                            _loc_8.attacked(_loc_9, -_loc_2.damage, _loc_2.fightSpecialRes, _loc_3.q_blood_num, _loc_10, 100, 1);
                        }
                        else
                        {
                            _loc_8.attacked(_loc_9, -_loc_2.damage, _loc_2.fightSpecialRes, 1, _loc_10, 100, 1);
                        }
                    }
                    else
                    {
                        _loc_8.attacked(_loc_9, -_loc_2.damage, _loc_2.fightSpecialRes);
                    }
                }
                if (_loc_2.back > 0)
                {
                    if (_loc_4.isMonster())
                    {
                        _loc_10 = MapUtils.countDirection(_loc_8._x, _loc_8._y, _loc_4._x, _loc_4._y);
                        if (_loc_3.q_blood_num > 1)
                        {
                            _loc_4.attacked(_loc_9, -_loc_2.back, 8, _loc_3.q_blood_num, _loc_10, 100, 1);
                        }
                        else
                        {
                            _loc_4.attacked(_loc_9, -_loc_2.back, 8, _loc_3.q_blood_num, _loc_10, 100, 1);
                        }
                    }
                    else
                    {
                        _loc_4.attacked(_loc_9, -_loc_2.back, 8);
                    }
                }
                if (_loc_5 == FightResultType.CRITICAL)
                {
                }
                else if (_loc_5 == FightResultType.MISS)
                {
                    if (_loc_8.isMonster())
                    {
                        _loc_6 = ObjectPool.CheckOut(getDefinitionByName("fightMonsterMiss") as Class);
                    }
                    else
                    {
                        _loc_6 = ObjectPool.CheckOut(getDefinitionByName("fightPlayerMiss") as Class);
                    }
                    if (_loc_8.isPlayer() && UICfg.hideOtherPlayer && !_loc_8.isUser())
                    {
                    }
                    else if ((_loc_8.isMonster() || _loc_8.isClientMonster()) && UICfg.NORMAL_MONSTER)
                    {
                    }
                    else
                    {
                        _loc_8.showTopCue(_loc_6, 0, 0, 0, 58, ScrollMC.MISS_TYPE, 1, 100, 0.5, true, 0, 0, 1, 22, 1);
                    }
                }
                else if (_loc_5 == FightResultType.BLOCK)
                {
                    _loc_6 = ToolKit.getNew("block_mc");
                    if (_loc_6)
                    {
                        _loc_8.showTopCue(_loc_6, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                    }
                }
                _loc_8.info.HP = _loc_2.currentHP;
                if (_loc_8.isUser())
                {
                    if (this.checkUserFree())
                    {
                        if (_loc_4.alive() && _loc_4.isMonster() && _loc_8)
                        {
                            _loc_11 = SkillCfgObj.getInstance().getSkillInfoById(UserObj.getInstance().playerInfo.defaultSkillId);
                            UserObj.getInstance().selectRole = _loc_4;
                            if (_loc_8.info.MP < _loc_11.q_need_mp)
                            {
                                this.useSkill(SkillControl.getInstance().getNormalSkillIdByJob(UserObj.getInstance().playerInfo.job), _loc_4);
                            }
                            else
                            {
                                this.useSkill(UserObj.getInstance().playerInfo.defaultSkillId, _loc_4);
                            }
                        }
                    }
                }
                if (_loc_8.info)
                {
                    _loc_8.info.HP = _loc_2.currentHP;
                }
                if (_loc_8.isMonster() || _loc_8.isClientMonster())
                {
                    if (!_loc_8.alive())
                    {
                        this.checkDie(_loc_4, _loc_8, _loc_3);
                    }
                }
            }
            if (_loc_3)
            {
                if (_loc_3.flyURL)
                {
                    if (!_loc_3.q_fly_Penetrate)
                    {
                    }
                }
                this._skillShowControl.showHit(_loc_4, _loc_8, _loc_3);
                if (_loc_4.isUser())
                {
                    if (_loc_3.q_shake_iskill)
                    {
                        if (_loc_8 && !_loc_8.alive())
                        {
                            _loc_12 = true;
                        }
                    }
                    if (_loc_3.q_shake_isluck)
                    {
                    }
                    if (_loc_3.q_shake_isperfect)
                    {
                        if (_loc_5 == FightResultType.CRITICAL)
                        {
                            _loc_12 = true;
                        }
                    }
                    if (_loc_3.q_shake_isignore)
                    {
                    }
                    if (_loc_3.q_shake_begin)
                    {
                        _loc_12 = true;
                    }
                    if (_loc_12)
                    {
                        if (this._currentGameScene)
                        {
                            this._currentGameScene.shock(_loc_3.q_shake_duration, _loc_3.q_shake_level);
                        }
                    }
                }
            }
            return;
        }// end function

        private function getRoleFromList(param1:IRole) : IRole
        {
            var _loc_2:* = this.attactList.length;
            var _loc_3:* = 1;
            while (_loc_3 < _loc_2)
            {
                
                if (param1 && param1.info && this.attactList[_loc_3].equal(param1.info.personId))
                {
                    return this._roleList.getRole(this.attactList[(_loc_3 - 1)]);
                }
                _loc_3++;
            }
            return null;
        }// end function

        private function getIndex(param1:IRole) : int
        {
            var _loc_2:* = this.attactList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1 && param1.info && this.attactList[_loc_3].equal(param1.info.personId))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        private function checkDie(param1:IRole, param2:IRole, param3:SkillInfo) : void
        {
            if (!param2)
            {
                return;
            }
            if (!param2.alive())
            {
                this._roleList.removeRole(param2);
                if (param3 && param3.q_whirlwind_dead > 0)
                {
                    if (param1)
                    {
                        param2.kickFly(param1, param3.q_whirlwind_dead);
                    }
                }
                else
                {
                    param2.dead();
                }
            }
            return;
        }// end function

        public function fightPostionBroadcastHandler(param1:ResFightPostionBroadcastMessage) : void
        {
            if (UserObj.getInstance().playerInfo.isPlayer(param1.personId))
            {
                return;
            }
            if (UICfg.hideOtherPlayer)
            {
                return;
            }
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = SkillCfgObj.getInstance().getSkillInfoById(param1.fightType);
            if (!_loc_3)
            {
                return;
            }
            _loc_3.targetX = param1.x;
            _loc_3.targetY = param1.y;
            _loc_2.direct = MapUtils.mapDirect2RoleDir(param1.fightDirection);
            _loc_2.info.currentSkill = _loc_3;
            _loc_2.attack();
            this._skillShowControl.showRelease(_loc_2, _loc_3);
            if (_loc_3.q_skill_type == 2)
            {
                _loc_2.stopWhenRelease = true;
            }
            else if (_loc_3.q_skill_type == 3)
            {
                _loc_2.stopWhenRelease = true;
            }
            return;
        }// end function

        public function fightBroadcastHandler(param1:ResFightBroadcastMessage) : void
        {
            if (UserObj.getInstance().playerInfo.isPlayer(param1.personId))
            {
                return;
            }
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (!_loc_2 || !_loc_2.info)
            {
                return;
            }
            if (UICfg.hideOtherPlayer && !_loc_2.isMonster() && !_loc_2.isSummonPet())
            {
                return;
            }
            var _loc_3:* = this._roleList.getRole(param1.fightTarget);
            if (!_loc_3 || !_loc_3.info)
            {
                return;
            }
            var _loc_4:* = SkillCfgObj.getInstance().getSkillInfoById(param1.fightType);
            if (!SkillCfgObj.getInstance().getSkillInfoById(param1.fightType))
            {
                return;
            }
            _loc_4.targetRole = _loc_3;
            _loc_4.targetX = _loc_3._x;
            _loc_4.targetY = _loc_3._y;
            _loc_2.info.currentSkill = _loc_4;
            _loc_2.face2(_loc_3._x, _loc_3._y);
            _loc_2.attack();
            this._skillShowControl.showRelease(_loc_2, _loc_4);
            return;
        }// end function

        public function fightFailedBroadcastHandler(param1:ResFightFailedBroadcastMessage) : void
        {
            if (!FrameworkGlobal.published)
            {
                SimpleTip.show("fightFailedBroadcast：" + ResultFailType.getMsg(param1.fightId.low) + "，fightType:" + param1.fightType);
            }
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2)
            {
                _loc_2.setAct(Params.ACTION_STAND_ID, true, false);
            }
            return;
        }// end function

        public function reqChangePKStateMessage(param1:int, param2:int = 1) : void
        {
            var _loc_3:* = null;
            if (UserObj.getInstance().playerInfo.level >= 60)
            {
                _loc_3 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID && _loc_3.zones_type != ZoneType.ZONES_RED_FORTRESS)
                {
                    this._protocol.reqChangePKStateMessage(param1, param2);
                }
                else
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10689"));
                }
            }
            return;
        }// end function

        public function resChangePKStateHandler(param1:ResChangePKStateMessage) : void
        {
            var _loc_2:* = param1.pkState;
            var _loc_3:* = param1.personId;
            if (_loc_3.equal(UserObj.getInstance().playerInfo.personId))
            {
                UserObj.getInstance().playerInfo.pkState = _loc_2;
            }
            return;
        }// end function

        public function attackRangeShow(param1:ResAttackRangeMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            for each (_loc_3 in param1.grids)
            {
                
                _loc_2 = ToolKit.creatRect(0, 0, 25, 25, 16711680, -1, 0.5);
                _loc_2.x = int(_loc_3 / 10000) * 25;
                _loc_2.y = _loc_3 % 10000 * 25;
                this._currentGameScene.tempLayer.addChild(_loc_2);
            }
            return;
        }// end function

        public function resDamageResultHandler(param1:ResDamageResultMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.playerID);
            if (_loc_2 && _loc_2.info)
            {
                _loc_2.info.dispatchEvt(new RoleEvent(RoleEvent.UPDATE_DU, [param1.type, param1.blood]));
            }
            return;
        }// end function

        public function finalize() : void
        {
            this._currentGameScene = null;
            return;
        }// end function

        public function checkUserFree() : Boolean
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            if (_loc_1.alive())
            {
                if (AutoFightManager.getInstance().isAutoFighting())
                {
                    return false;
                }
                if (_loc_1.fatherActType == Params.ACTION_RUN)
                {
                    return false;
                }
                if (_loc_1.isPathing)
                {
                    return false;
                }
                if (_loc_1.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
                {
                    return false;
                }
                if (_loc_1.info && _loc_1.info.currentSkill && _loc_1.info.currentSkill.hasTarget())
                {
                    return false;
                }
                if (UserObj.getInstance().playerInfo.fightState == 0)
                {
                    return false;
                }
                if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.isPlayer())
                {
                    return false;
                }
                if (TaskGlobal.manager.isTaskDialogOpen() || NpcDialogControl.getInstance().isNpcDialogOpen() || ShopController.getInstance().isShopOpen())
                {
                    return false;
                }
                if (_loc_1.isStopAutoFightBack)
                {
                    return false;
                }
                if (AutoFightManager.getInstance().isAutoFighting())
                {
                    return false;
                }
                return true;
            }
            return false;
        }// end function

        public function showFireWallSkill(param1:EffectInfo, param2:Boolean = false) : void
        {
            if (UICfg.SCREEN_EFFECT)
            {
                return;
            }
            var _loc_3:* = param1.effectModelId;
            var _loc_4:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_3);
            switch(_loc_3)
            {
                case SpecialSkillID.SKILL_BRAIN_STORM:
                case SpecialSkillID.Skill_HEAVEN_ARROW:
                {
                    this.showBrainStormSkill(param1);
                    break;
                }
                case SpecialSkillID.SKILL_HUO_JIAN_XI:
                {
                    this.showFireSwordSkill(param1, param2);
                    break;
                }
                default:
                {
                    this._currentGameScene.bgView.addedSkillBgEffect(_loc_4.q_hit_ground_effect, param1.x, param1.y, param1.effectId.toNumber());
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function removeFireWallSkill(param1:Vector.<long>) : void
        {
            this._roundEffectDisappear(param1);
            this.removeBrainStormSkill(param1);
            this.removeFireSwordSkill(param1);
            return;
        }// end function

        private function _roundEffectDisappear(param1:Vector.<long>) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._currentGameScene.bgView.removeSkillBgEffect(param1[_loc_3].toNumber());
                _loc_3++;
            }
            return;
        }// end function

        private function showFireSwordSkill(param1:EffectInfo, param2:Boolean = false) : void
        {
            this._skillShowControl.showFireSwordSkill(param1, param2);
            return;
        }// end function

        public function removeFireSwordSkill(param1:Vector.<long>) : void
        {
            this._skillShowControl.removeFireSwordSkill(param1);
            return;
        }// end function

        public function showBrainStormSkill(param1:EffectInfo) : void
        {
            this._skillShowControl.showBrainStormSkill(param1);
            return;
        }// end function

        public function removeBrainStormSkill(param1:Vector.<long>) : void
        {
            this._skillShowControl.removeBrainStormSkill(param1);
            return;
        }// end function

        public function resflashMove(param1:ResFlashMoveMessage) : void
        {
            var r1:IRole;
            var msg:* = param1;
            var skillInfo:* = SkillCfgObj.getInstance().getSkillInfoById(msg.skillModel);
            r1 = this._roleList.getRole(msg.roleId);
            var position:* = msg.position;
            if (!r1 || !r1.info)
            {
                Log.log("攻击者不存在，或者已经死亡");
                return;
            }
            TweenLite.delayedCall(0.6, function () : void
            {
                r1.visible = false;
                return;
            }// end function
            );
            var time:* = skillInfo.q_skill_time / 1000;
            TweenLite.delayedCall(time, this.step2, [r1, skillInfo, position]);
            r1.isInSkillShunyi = true;
            return;
        }// end function

        private function step1(param1:IRole, param2:SkillInfo) : void
        {
            this._skillShowControl.showRelease(param1, param2);
            return;
        }// end function

        private function step2(param1:IRole, param2:SkillInfo, param3:Position) : void
        {
            param2.targetRole = param1;
            this._skillShowControl.showHit(param1, param1, param2);
            this._skillShowControl.showFly(param1, param2);
            param1.move(param3.x, param3.y);
            MapControl.getInstance().currentGameScene.roleMoveHandler();
            param1.visible = true;
            param1.isInSkillShunyi = false;
            return;
        }// end function

        public function resComboHandler(param1:ResComboMessage) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.personId;
            switch(param1.value)
            {
                case 1:
                {
                    this.setComboStep(2, param1.playerid);
                    break;
                }
                case 2:
                {
                    this.setComboStep(3, param1.playerid);
                    break;
                }
                case 3:
                {
                    if (param1.playerid.equal(_loc_2))
                    {
                        TweenLite.killDelayedCallsTo(this.hideComboIcon);
                        this.hideComboIcon();
                        TweenLite.delayedCall(10, this.setComboStep, [1, _loc_2]);
                    }
                    _loc_3 = RoleList.getInstance().getRole(param1.playerid);
                    if (_loc_3)
                    {
                        _loc_3.showComboEffect();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setComboStep(param1:int, param2:long) : void
        {
            TweenLite.killDelayedCallsTo(this.hideComboIcon);
            var _loc_3:* = UserObj.getInstance().playerInfo.personId;
            if (param2.equal(_loc_3))
            {
                if (!this.iconCombo)
                {
                    this.iconCombo = new SkillComboIcon();
                }
                this.iconCombo.setStepInfo(param1);
                this.iconCombo.mouseEnabled = false;
                Global.mainUIManager.addUI(this.iconCombo, new LayoutInfo(Layout.BOTTOM_CENTER, -155, 126));
            }
            var _loc_4:* = GlobalCfgObj.getInstance().getSkillComboDelayHide();
            TweenLite.delayedCall(_loc_4, this.hideComboIcon);
            return;
        }// end function

        private function hideComboIcon() : void
        {
            if (this.iconCombo && this.iconCombo.parent)
            {
                this.iconCombo.parent.removeChild(this.iconCombo);
                this.iconCombo.finalize();
                this.iconCombo = null;
            }
            return;
        }// end function

        public static function getInstance() : FightControl
        {
            if (instance == null)
            {
                instance = new FightControl;
            }
            return instance;
        }// end function

    }
}
