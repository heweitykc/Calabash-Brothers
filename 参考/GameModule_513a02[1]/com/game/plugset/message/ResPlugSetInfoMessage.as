package com.game.plugset.message
{
    import com.game.plugset.bean.*;
    import net.*;

    public class ResPlugSetInfoMessage extends Message
    {
        private var _plugsetinfo:PlugSetInfo;

        public function ResPlugSetInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._plugsetinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._plugsetinfo = readBean(PlugSetInfo) as PlugSetInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 131101;
        }// end function

        public function get plugsetinfo() : PlugSetInfo
        {
            return this._plugsetinfo;
        }// end function

        public function set plugsetinfo(param1:PlugSetInfo) : void
        {
            this._plugsetinfo = param1;
            return;
        }// end function

    }
}
