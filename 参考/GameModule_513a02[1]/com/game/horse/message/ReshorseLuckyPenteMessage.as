package com.game.horse.message
{
    import com.game.horse.bean.*;
    import net.*;

    public class ReshorseLuckyPenteMessage extends Message
    {
        private var _num:int;
        private var _skillinfo:CSHorseSkillInfo;

        public function ReshorseLuckyPenteMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._num);
            writeBean(this._skillinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readByte();
            this._skillinfo = readBean(CSHorseSkillInfo) as CSHorseSkillInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 126107;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get skillinfo() : CSHorseSkillInfo
        {
            return this._skillinfo;
        }// end function

        public function set skillinfo(param1:CSHorseSkillInfo) : void
        {
            this._skillinfo = param1;
            return;
        }// end function

    }
}
