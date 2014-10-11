package com.game.autopk.controller
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.model.*;
    import com.game.common.*;
    import com.game.fight.control.*;
    import com.game.map.model.*;
    import com.game.team.bean.*;
    import com.game.team.model.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class SkillLogic extends Object
    {
        private var _selectMounster:IRole;
        private var _useSkillList:Vector.<DoSkillVO>;
        private var defaultSkill:SkillInfo;
        private const FIRST_SKILL:Array;

        public function SkillLogic()
        {
            this.FIRST_SKILL = [10001, 10011, 10020];
            return;
        }// end function

        public function autoUseSkill(param1:IRole, param2:Boolean = false) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this._selectMounster = param1;
            var _loc_3:* = this.getCurrentSkill();
            if (_loc_3 == null)
            {
                return;
            }
            var _loc_4:* = RoleList.getInstance().player;
            if (this._selectMounster && !_loc_3.isTargetSelf())
            {
                _loc_6 = ToolKit.distance(_loc_4.px, _loc_4.py, MapUtils.coo2Tile(this._selectMounster._x), MapUtils.coo2Tile(this._selectMounster._y));
            }
            FightControl.getInstance().delCurrentSkill();
            var _loc_5:* = _loc_3.q_skillID;
            if (param2 || UserObj.getInstance().playerInfo.currentSkill && UserObj.getInstance().playerInfo.currentSkill.q_skillID == _loc_5)
            {
                UserObj.getInstance().playerInfo.currentSkill = _loc_3;
                _loc_3.targetX = this._selectMounster._x;
                _loc_3.targetY = this._selectMounster._y;
                FightControl.getInstance().useSkill(_loc_5, this._selectMounster, this._selectMounster._x, this._selectMounster._y);
                FightControl.getInstance().checkAndAttack(_loc_4);
                return;
            }
            if (this._selectMounster)
            {
                _loc_7 = new DoSkillVO();
                _loc_7.info = _loc_3;
                if (_loc_7.isCallSkill)
                {
                    FightControl.getInstance().useSkill(_loc_5, null);
                }
                else
                {
                    FightControl.getInstance().useSkill(_loc_5, this._selectMounster, this._selectMounster._x, this._selectMounster._y);
                }
            }
            return;
        }// end function

        public function autoUseHelpSkill() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (this.useSkillList && this.useSkillList.length)
            {
                _loc_1 = this.useSkillList.length;
                _loc_2 = getTimer();
                if (AutoFightModel.fightType != 2)
                {
                    return;
                }
                _loc_4 = 0;
                while (_loc_4 < _loc_1)
                {
                    
                    _loc_3 = this.useSkillList[_loc_4];
                    if (_loc_3.isHelpBloodSkill)
                    {
                        Tracer.debug("---检查辅助-加血技能-----" + _loc_3.info.q_skillName + "-----------");
                        this.useHelpBloodSkill(_loc_3);
                    }
                    else if (_loc_3.isHelpBuffSkill)
                    {
                        Tracer.debug("---检查辅助-增益BUFF技能-----" + _loc_3.info.q_skillName + "-----------");
                        this.useHelpBuffSkill(_loc_3);
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        public function get useSkillList() : Vector.<DoSkillVO>
        {
            return this._useSkillList;
        }// end function

        public function set useSkillList(param1:Vector.<DoSkillVO>) : void
        {
            this._useSkillList = param1;
            return;
        }// end function

        public function initSkill() : void
        {
            var _loc_1:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this.useSkillList = new Vector.<DoSkillVO>;
            var _loc_2:* = SkillCfgObj.getInstance().getSkillSortTable();
            var _loc_3:* = UserObj.getInstance().playerInfo.job;
            var _loc_4:* = _loc_2[_loc_3];
            var _loc_5:* = [];
            for (_loc_6 in _loc_4)
            {
                
                if (_loc_6.indexOf("q_skill_") != -1 && _loc_4[_loc_6] != "")
                {
                    _loc_5.push(int(_loc_4[_loc_6]));
                }
            }
            _loc_7 = int(_loc_4["q_default"]);
            if (_loc_7 > 0)
            {
                this.defaultSkill = SkillCfgObj.getInstance().getSkillInfoById(_loc_7);
            }
            if (AutoFightModel.fightSkill == 1)
            {
                _loc_1 = UserObj.getInstance().playerInfo.skillList;
            }
            else
            {
                _loc_11 = AutoFightModel.skillIdList;
                if (!_loc_11)
                {
                    return;
                }
                _loc_1 = new Vector.<SkillInfo>;
                _loc_12 = 0;
                while (_loc_12 < _loc_11.length)
                {
                    
                    _loc_13 = _loc_11[_loc_12];
                    _loc_14 = SkillCfgObj.getInstance().getSkillInfoById(_loc_13);
                    _loc_1.push(_loc_14);
                    _loc_12++;
                }
            }
            if (!_loc_1)
            {
                return;
            }
            var _loc_8:* = _loc_1.length;
            var _loc_9:* = [];
            var _loc_10:* = 0;
            _loc_12 = 0;
            while (_loc_12 < _loc_8)
            {
                
                if (_loc_9.indexOf(_loc_1[_loc_12].q_skillID) == -1 && this.FIRST_SKILL.indexOf(_loc_1[_loc_12].q_skillID) == -1 && _loc_5.indexOf(_loc_1[_loc_12].q_skillID) != -1)
                {
                    _loc_9.push(_loc_1[_loc_12].q_skillID);
                    _loc_15 = new DoSkillVO();
                    _loc_15.info = _loc_1[_loc_12];
                    this.useSkillList[_loc_10] = _loc_15;
                    _loc_10++;
                }
                _loc_12++;
            }
            this.useSkillList.sort(this.sortSkill);
            return;
        }// end function

        private function sortSkill(param1:DoSkillVO, param2:DoSkillVO) : Number
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_3:* = SkillCfgObj.getInstance().getSkillSortTable();
            var _loc_4:* = UserObj.getInstance().playerInfo.job;
            var _loc_5:* = _loc_3[_loc_4];
            var _loc_6:* = "" + param1.info.q_skillID;
            var _loc_7:* = "" + param2.info.q_skillID;
            for (_loc_8 in _loc_5)
            {
                
                if (_loc_8.indexOf("q_skill_") != -1)
                {
                    if (_loc_5[_loc_8] == _loc_6)
                    {
                        break;
                    }
                }
            }
            for (_loc_9 in _loc_5)
            {
                
                if (_loc_8.indexOf("q_skill_") != -1)
                {
                    if (_loc_5[_loc_9] == _loc_7)
                    {
                        break;
                    }
                }
            }
            _loc_10 = int(_loc_8.replace("q_skill_", ""));
            _loc_11 = int(_loc_9.replace("q_skill_", ""));
            return _loc_10 - _loc_11;
        }// end function

        private function getCurrentSkill() : SkillInfo
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = false;
            if (this.useSkillList && this.useSkillList.length)
            {
                _loc_1 = this.useSkillList.length;
                _loc_2 = getTimer();
                Tracer.debug("---------" + _loc_1 + "-----------");
                _loc_4 = 0;
                while (_loc_4 < _loc_1)
                {
                    
                    _loc_3 = this.useSkillList[_loc_4];
                    _loc_5 = this.checkSkill(_loc_3);
                    if (_loc_5)
                    {
                        if (!_loc_3.info.isTargetFriend() && !_loc_3.info.isTargetSelf())
                        {
                            _loc_3.info.targetRole = this._selectMounster;
                        }
                        return _loc_3.info;
                    }
                    _loc_4++;
                }
            }
            if (this.defaultSkill)
            {
                return this.defaultSkill;
            }
            return null;
        }// end function

        private function checkSkill(param1:DoSkillVO) : Boolean
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = true;
            Tracer.debug("开始检查技能" + param1.info.q_skillName);
            var _loc_4:* = CDManager.getInstance().isInCD(CDTypes.SKILL, param1.info.q_skillID, param1.info.q_public_cd_level);
            if (CDManager.getInstance().isInCD(CDTypes.SKILL, param1.info.q_skillID, param1.info.q_public_cd_level))
            {
                Tracer.debug(">>>" + param1.info.q_skillName + "CD冷却时间不够");
                return false;
            }
            var _loc_5:* = UserObj.getInstance().playerInfo.MP;
            _loc_3 = UserObj.getInstance().playerInfo.MP > param1.info.q_need_mp;
            if (!_loc_3)
            {
                Tracer.debug(">>>" + param1.info.q_skillName + "MP不够");
                return _loc_3;
            }
            if (param1.isCallSkill)
            {
                _loc_6 = UserObj.getInstance().playerInfo.summonPetInfo;
                _loc_7 = UserObj.getInstance().playerInfo.skillList;
                _loc_9 = false;
                for each (_loc_8 in _loc_7)
                {
                    
                    if (_loc_8 && _loc_8.q_skillID == Params.TWO_PET_SKILL_ID)
                    {
                        _loc_9 = true;
                        break;
                    }
                }
                if (_loc_9)
                {
                    if (_loc_6 && UserObj.getInstance().playerInfo.getSummonPetTypeNum() >= 2 || UserObj.getInstance().playerInfo.hasSummonPetType(_loc_8.q_animal_id + UserObj.getInstance().playerInfo.level))
                    {
                        return false;
                    }
                    return true;
                }
                else if (UserObj.getInstance().playerInfo.getSummonPetTypeNum() > 0)
                {
                    Tracer.debug(">>>" + param1.info.q_skillName + "已经有召唤");
                    return false;
                }
            }
            if (param1.isGroupSkill)
            {
                _loc_10 = param1.info.q_range_limit * 25;
                _loc_11 = RoleList.getInstance().nearMonstersList;
                _loc_3 = this.getMonsterliveCount(_loc_11) > 1;
                if (!_loc_3)
                {
                    Tracer.debug(">>>" + param1.info.q_skillName + "周围人数太少");
                    return _loc_3;
                }
            }
            if (param1.isBuffSkill)
            {
                _loc_12 = UserObj.getInstance().playerInfo.buffs;
                _loc_13 = param1.info.q_passive_buff;
                if (_loc_13 && _loc_13.length)
                {
                    _loc_14 = 0;
                    while (_loc_14 < _loc_13.length)
                    {
                        
                        _loc_15 = _loc_13[_loc_14];
                        _loc_16 = 0;
                        while (_loc_16 < _loc_12.length)
                        {
                            
                            if (int(_loc_12[_loc_16].q_buff_id) == _loc_15)
                            {
                                if (AutoFightModel.fightType == 1)
                                {
                                    Tracer.debug(">>>" + param1.info.q_skillName + "已经有BUFF");
                                    return false;
                                }
                                _loc_3 = this.useHelpBuffSkill(param1);
                                if (_loc_3)
                                {
                                    Tracer.debug(">>>" + param1.info.q_skillName + "辅助");
                                }
                                return _loc_3;
                            }
                            _loc_16++;
                        }
                        _loc_14++;
                    }
                }
            }
            if (param1.isAddBlood)
            {
                if (AutoFightModel.fightType == 1)
                {
                    _loc_17 = 100 * UserObj.getInstance().playerInfo.HP / UserObj.getInstance().playerInfo.HPMax;
                    _loc_3 = _loc_17 < AutoFightModel.hp;
                    if (!_loc_3)
                    {
                        Tracer.debug(">>>" + param1.info.q_skillName + "HP 值很充足");
                        return _loc_3;
                    }
                }
                else if (AutoFightModel.fightType == 2)
                {
                    _loc_3 = this.useHelpBloodSkill(param1);
                    if (_loc_3)
                    {
                        Tracer.debug(">>>" + param1.info.q_skillName + "辅助");
                    }
                    return _loc_3;
                }
            }
            Tracer.debug("^^^^^^" + param1.info.q_skillName);
            return true;
        }// end function

        private function getMonsterliveCount(param1:Vector.<IRole>) : int
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                if (param1[_loc_4].alive())
                {
                    _loc_3++;
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private function useHelpBuffSkill(param1:DoSkillVO) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            if (param1.isHelpBuffSkill)
            {
                if (AutoFightModel.fightType == 2)
                {
                    _loc_2 = 1000;
                    _loc_3 = this.getNearTeamMember(_loc_2);
                    if (!_loc_3 && _loc_3.length == 0)
                    {
                        return false;
                    }
                    _loc_4 = int.MAX_VALUE;
                    _loc_7 = RoleList.getInstance().player;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_3.length)
                    {
                        
                        _loc_9 = _loc_3[_loc_8];
                        if (!_loc_9 || !_loc_9.alive())
                        {
                        }
                        else
                        {
                            _loc_10 = this.checkBuff(_loc_9, param1.info);
                            if (!_loc_10)
                            {
                                _loc_11 = _loc_7.distanceSQ(_loc_9);
                                _loc_11 = Math.sqrt(_loc_11);
                                _loc_6 = MapUtils.findPath(MapObj.getInstance().tilesba, MapUtils.coo2Tile(_loc_7._x), MapUtils.coo2Tile(_loc_7._y), MapUtils.coo2Tile(_loc_9._x), MapUtils.coo2Tile(_loc_9._y), 0, RoleList.NEAR_RANGE);
                                if (_loc_11 < _loc_4 && _loc_6)
                                {
                                    _loc_4 = _loc_11;
                                    _loc_5 = _loc_9;
                                }
                            }
                        }
                        _loc_8++;
                    }
                    if (_loc_5)
                    {
                        param1.info.targetRole = _loc_5;
                        _loc_12 = param1.info.q_skillID;
                        FightControl.getInstance().useSkill(_loc_12, _loc_5, _loc_5._x, _loc_5._y);
                        FightControl.getInstance().checkAndAttack(RoleList.getInstance().player);
                        this._selectMounster = _loc_5;
                        Tracer.debug(">>>" + param1.info.q_skillName + "--ok");
                        return true;
                    }
                }
            }
            return false;
        }// end function

        private function useHelpBloodSkill(param1:DoSkillVO) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (param1.isHelpBloodSkill)
            {
                if (AutoFightModel.fightType == 2 && UserObj.getInstance().playerInfo.pkState != 2)
                {
                    _loc_2 = 1000;
                    _loc_3 = this.getNearTeamMember(_loc_2);
                    if (!_loc_3 && _loc_3.length == 0)
                    {
                        return false;
                    }
                    _loc_4 = 100;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_3.length)
                    {
                        
                        _loc_8 = _loc_3[_loc_7];
                        if (!_loc_8 || !_loc_8.alive())
                        {
                        }
                        else
                        {
                            _loc_9 = RoleList.getInstance().player.distanceSQ(_loc_8);
                            _loc_9 = Math.sqrt(_loc_9);
                            _loc_6 = 100 * _loc_8.info.HP / _loc_8.info.HPMax;
                            if (_loc_6 < _loc_4)
                            {
                                _loc_4 = _loc_6;
                                _loc_5 = _loc_8;
                            }
                        }
                        _loc_7++;
                    }
                    if (_loc_5 && _loc_4 < 60)
                    {
                        param1.info.targetRole = _loc_5;
                        _loc_10 = param1.info.q_skillID;
                        FightControl.getInstance().useSkill(_loc_10, _loc_5, _loc_5._x, _loc_5._y);
                        FightControl.getInstance().checkAndAttack(RoleList.getInstance().player);
                        this._selectMounster = _loc_5;
                        Tracer.debug(">>>" + param1.info.q_skillName + "--ok");
                        return true;
                    }
                    _loc_6 = 100 * RoleList.getInstance().player.info.HP / RoleList.getInstance().player.info.HPMax;
                    return _loc_6 <= AutoFightModel.hp;
                }
            }
            return false;
        }// end function

        private function checkBuff(param1:IRole, param2:SkillInfo) : Boolean
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = param1.info.buffs;
            var _loc_4:* = param2.q_passive_buff;
            if (param2.q_passive_buff && _loc_4.length)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    _loc_6 = _loc_4[_loc_5];
                    _loc_7 = 0;
                    while (_loc_7 < _loc_3.length)
                    {
                        
                        if (int(_loc_3[_loc_7].q_buff_id) == _loc_6)
                        {
                            Tracer.debug(">>>" + param1.info.name + "已经有" + param2.q_skillName + "BUFF");
                            return true;
                        }
                        _loc_7++;
                    }
                    _loc_5++;
                }
            }
            return false;
        }// end function

        private function onArriveTargetHandler(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            _loc_2.removeEvtListener(RoleEvent.ARRIVE, this.onArriveTargetHandler);
            if (this._selectMounster && this._selectMounster.alive())
            {
                this.autoUseSkill(this._selectMounster);
            }
            return;
        }// end function

        public function getNearTeamMember(param1:int) : Vector.<IRole>
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = new Vector.<IRole>;
            var _loc_4:* = RoleList.getInstance().player;
            for each (_loc_5 in TeamModel.getInstance().vecTeamInfo)
            {
                
                _loc_3 = RoleList.getInstance().getRole(_loc_5.memberid);
                if (_loc_3 && _loc_3.alive() && !_loc_3.isUser())
                {
                    _loc_6 = _loc_4.distanceSQ(_loc_3);
                    _loc_6 = Math.sqrt(_loc_6);
                    if (_loc_6 < param1)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function finalize() : void
        {
            var _loc_1:* = RoleList.getInstance().player;
            _loc_1.removeEvtListener(RoleEvent.ARRIVE, this.onArriveTargetHandler);
            return;
        }// end function

    }
}
