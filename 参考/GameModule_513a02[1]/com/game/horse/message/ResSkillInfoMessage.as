package com.game.horse.message
{
    import __AS3__.vec.*;
    import com.game.horse.bean.*;
    import net.*;

    public class ResSkillInfoMessage extends Message
    {
        private var _skillinfolist:Vector.<CSHorseSkillInfo>;
        private var _money:int;
        private var _yuanbao:int;

        public function ResSkillInfoMessage()
        {
            this._skillinfolist = new Vector.<CSHorseSkillInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._skillinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._skillinfolist.length)
            {
                
                writeBean(this._skillinfolist[_loc_1]);
                _loc_1++;
            }
            writeInt(this._money);
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._skillinfolist[_loc_1] = readBean(CSHorseSkillInfo) as CSHorseSkillInfo;
                _loc_1++;
            }
            this._money = readInt();
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126114;
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

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get yuanbao() : int
        {
            return this._yuanbao;
        }// end function

        public function set yuanbao(param1:int) : void
        {
            this._yuanbao = param1;
            return;
        }// end function

    }
}
