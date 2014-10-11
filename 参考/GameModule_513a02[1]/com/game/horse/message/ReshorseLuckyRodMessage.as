package com.game.horse.message
{
    import __AS3__.vec.*;
    import com.game.horse.bean.*;
    import net.*;

    public class ReshorseLuckyRodMessage extends Message
    {
        private var _num:int;
        private var _skillinfolist:Vector.<CSHorseSkillInfo>;

        public function ReshorseLuckyRodMessage()
        {
            this._skillinfolist = new Vector.<CSHorseSkillInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._num);
            writeShort(this._skillinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._skillinfolist.length)
            {
                
                writeBean(this._skillinfolist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._num = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._skillinfolist[_loc_1] = readBean(CSHorseSkillInfo) as CSHorseSkillInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 126106;
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

        public function get skillinfolist() : Vector.<CSHorseSkillInfo>
        {
            return this._skillinfolist;
        }// end function

        public function set skillinfolist(param1:Vector.<CSHorseSkillInfo>) : void
        {
            this._skillinfolist = param1;
            return;
        }// end function

    }
}
