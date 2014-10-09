package com.game.horse.message
{
    import com.game.horse.bean.*;
    import net.*;

    public class ReshorseReceiveMessage extends Message
    {
        private var _horseinfo:CSHorseInfo;

        public function ReshorseReceiveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._horseinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._horseinfo = readBean(CSHorseInfo) as CSHorseInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 126108;
        }// end function

        public function get horseinfo() : CSHorseInfo
        {
            return this._horseinfo;
        }// end function

        public function set horseinfo(param1:CSHorseInfo) : void
        {
            this._horseinfo = param1;
            return;
        }// end function

    }
}
