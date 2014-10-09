package com.game.epalace.message
{
    import com.game.epalace.bean.*;
    import net.*;

    public class ResEpalaceWalkToClientMessage extends Message
    {
        private var _epalaceInfo:EpalaceInfo;

        public function ResEpalaceWalkToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._epalaceInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._epalaceInfo = readBean(EpalaceInfo) as EpalaceInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 143101;
        }// end function

        public function get epalaceInfo() : EpalaceInfo
        {
            return this._epalaceInfo;
        }// end function

        public function set epalaceInfo(param1:EpalaceInfo) : void
        {
            this._epalaceInfo = param1;
            return;
        }// end function

    }
}
