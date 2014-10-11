package com.game.magicbook.message
{
    import __AS3__.vec.*;
    import com.game.magicbook.bean.*;
    import net.*;

    public class ResSeeOtherMagicbookMessage extends Message
    {
        private var _potential:int;
        private var _star:int;
        private var _level:int;
        private var _attrs:Vector.<MagicAttrInfo>;
        private var _skills:Vector.<MagicSkillInfo>;

        public function ResSeeOtherMagicbookMessage()
        {
            this._attrs = new Vector.<MagicAttrInfo>;
            this._skills = new Vector.<MagicSkillInfo>;
            return;
        }// end function

        public function set potential(param1:int) : void
        {
            this._potential = param1;
            return;
        }// end function

        public function get potential() : int
        {
            return this._potential;
        }// end function

        public function set star(param1:int) : void
        {
            this._star = param1;
            return;
        }// end function

        public function get star() : int
        {
            return this._star;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set attrs(param1:Vector.<MagicAttrInfo>) : void
        {
            this._attrs = param1;
            return;
        }// end function

        public function get attrs() : Vector.<MagicAttrInfo>
        {
            return this._attrs;
        }// end function

        public function set skills(param1:Vector.<MagicSkillInfo>) : void
        {
            this._skills = param1;
            return;
        }// end function

        public function get skills() : Vector.<MagicSkillInfo>
        {
            return this._skills;
        }// end function

        override public function getId() : int
        {
            return 600027;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._potential);
            writeInt(this._star);
            writeInt(this._level);
            writeShort(this._attrs.length);
            _loc_1 = 0;
            while (_loc_1 < this._attrs.length)
            {
                
                writeBean(this._attrs[_loc_1]);
                _loc_1++;
            }
            writeShort(this._skills.length);
            _loc_1 = 0;
            while (_loc_1 < this._skills.length)
            {
                
                writeBean(this._skills[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._potential = readInt();
            this._star = readInt();
            this._level = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._attrs[_loc_2] = readBean(MagicAttrInfo) as MagicAttrInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._skills[_loc_2] = readBean(MagicSkillInfo) as MagicSkillInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
