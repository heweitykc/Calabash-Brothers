package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.game.magicbook.bean.*;
    import com.game.utils.*;
    import flash.utils.*;

    public class MagicBookInfo extends RoleInfo
    {
        private var _modelString:int;
        private var _magicAttrInfos:Dictionary;
        private var _exp_m:int;
        private var _potential:int;
        private var _skills_m:Vector.<MagicSkillInfo>;
        private var _useOnces:Vector.<MagicUseOnceInfo>;
        private var _magicSkill:MagicBookSkillInfo;
        public var parentId:long;
        public var petType:int;

        public function MagicBookInfo()
        {
            this._skills_m = new Vector.<MagicSkillInfo>;
            this._useOnces = new Vector.<MagicUseOnceInfo>;
            return;
        }// end function

        public function get magicSkill() : MagicBookSkillInfo
        {
            return this._magicSkill;
        }// end function

        public function set magicSkill(param1:MagicBookSkillInfo) : void
        {
            this._magicSkill = param1;
            return;
        }// end function

        public function set useOnces(param1:Vector.<MagicUseOnceInfo>) : void
        {
            this._useOnces = param1;
            dispatchEvt(new MagicBookEvent(MagicBookEvent.USEITEM_CHANGE));
            return;
        }// end function

        public function get useOnces() : Vector.<MagicUseOnceInfo>
        {
            return this._useOnces;
        }// end function

        public function set skills_m(param1:Vector.<MagicSkillInfo>) : void
        {
            this._skills_m = param1;
            dispatchEvt(new MagicBookEvent(MagicBookEvent.SKILL_CHANGE));
            return;
        }// end function

        public function get skills_m() : Vector.<MagicSkillInfo>
        {
            return this._skills_m;
        }// end function

        public function get potential() : int
        {
            return this._potential;
        }// end function

        public function set potential(param1:int) : void
        {
            this._potential = param1;
            return;
        }// end function

        public function getMagicStar() : int
        {
            return (Math.floor((_level - 1) / 20) + 1);
        }// end function

        public function getMagicLevel() : int
        {
            return (_level - 1) % 20 + 1;
        }// end function

        public function get exp_m() : int
        {
            return this._exp_m;
        }// end function

        public function set exp_m(param1:int) : void
        {
            this._exp_m = param1;
            dispatchEvt(new MagicBookEvent(MagicBookEvent.EXP_CHANGE));
            return;
        }// end function

        public function getMagicAttrInfo(param1:int) : MagicAttrInfo
        {
            if (!this._magicAttrInfos)
            {
                return null;
            }
            return this._magicAttrInfos[param1];
        }// end function

        public function setMagicAttrInfos(param1:Vector.<MagicAttrInfo>) : void
        {
            var _loc_3:* = null;
            this._magicAttrInfos = new Dictionary();
            var _loc_2:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = param1[_loc_4];
                this._magicAttrInfos[_loc_3.attrId] = _loc_3;
                _loc_4++;
            }
            dispatchEvt(new MagicBookEvent(MagicBookEvent.ATTRINFO_CHANGE));
            return;
        }// end function

        public function conByParentInfo(param1:RoleInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 is PlayerInfo)
            {
                this.parentId = new long(param1.personId.low, param1.personId.high);
                _loc_2 = (param1 as PlayerInfo).magicBook;
                if (_loc_2)
                {
                    level = _loc_2.level;
                }
                x = param1.x - 50;
                y = param1.y - 50;
                mapId = param1.mapId;
                speed = param1.speed * 1;
                _loc_3 = QMagicbookLevelCfg.getInstance().getMagicBookCfg(level);
                url = _loc_3.gameModelUrl;
            }
            else
            {
                throw "非玩家";
            }
            return;
        }// end function

    }
}
