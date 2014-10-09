package com.game.scripts.message
{
    import com.game.scripts.bean.*;
    import net.*;

    public class ResShowPaneleInfoToClientMessage extends Message
    {
        private var _panelInfo:PanelInfo;

        public function ResShowPaneleInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._panelInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._panelInfo = readBean(PanelInfo) as PanelInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 148102;
        }// end function

        public function get panelInfo() : PanelInfo
        {
            return this._panelInfo;
        }// end function

        public function set panelInfo(param1:PanelInfo) : void
        {
            this._panelInfo = param1;
            return;
        }// end function

    }
}
