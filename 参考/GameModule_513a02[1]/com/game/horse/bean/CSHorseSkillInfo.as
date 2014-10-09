package com.game.horse.bean
{
    import net.*;

    public class CSHorseSkillInfo extends Bean
    {
        private var _skilllevel:int;
        private var _skillmodelid:int;
        private var _skillexp:int;

        public function CSHorseSkillInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._skilllevel);
            writeInt(this._skillmodelid);
            writeInt(this._skillexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skilllevel = readShort();
            this._skillmodelid = readInt();
            this._skillexp = readInt();
            return true;
        }// end function

        public function get skilllevel() : int
        {
            return this._skilllevel;
        }// end function

        public function set skilllevel(param1:int) : void
        {
            this._skilllevel = param1;
            return;
        }// end function

        public function get skillmodelid() : int
        {
            return this._skillmodelid;
        }// end function

        public function set skillmodelid(param1:int) : void
        {
            this._skillmodelid = param1;
            return;
        }// end function

        public function get skillexp() : int
        {
            return this._skillexp;
        }// end function

        public function set skillexp(param1:int) : void
        {
            this._skillexp = param1;
            return;
        }// end function

    }
}
