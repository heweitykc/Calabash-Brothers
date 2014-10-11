package com.game.lostskills.message
{
    import __AS3__.vec.*;
    import com.game.lostskills.bean.*;
    import net.*;

    public class ResLostSkillInfosMessage extends Message
    {
        private var _skillInfos:Vector.<LostSkillInfo>;

        public function ResLostSkillInfosMessage()
        {
            this._skillInfos = new Vector.<LostSkillInfo>;
            return;
        }// end function

        public function set skillInfos(param1:Vector.<LostSkillInfo>) : void
        {
            this._skillInfos = param1;
            return;
        }// end function

        public function get skillInfos() : Vector.<LostSkillInfo>
        {
            return this._skillInfos;
        }// end function

        override public function getId() : int
        {
            return 600007;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._skillInfos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._skillInfos.length)
            {
                
                writeBean(this._skillInfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skillInfos[_loc_2] = readBean(LostSkillInfo) as LostSkillInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
