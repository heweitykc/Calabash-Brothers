package com.game.longyuan.message
{
    import com.game.longyuan.bean.*;
    import net.*;

    public class ResShowEffectToClientMessage extends Message
    {
        private var _showeffectinfo:ShowEffectInfo;

        public function ResShowEffectToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._showeffectinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._showeffectinfo = readBean(ShowEffectInfo) as ShowEffectInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 115106;
        }// end function

        public function get showeffectinfo() : ShowEffectInfo
        {
            return this._showeffectinfo;
        }// end function

        public function set showeffectinfo(param1:ShowEffectInfo) : void
        {
            this._showeffectinfo = param1;
            return;
        }// end function

    }
}
