package com.game.scripts.message
{
    import com.game.scripts.bean.*;
    import net.*;

    public class ResPanelStatusInfoToClientMessage extends Message
    {
        private var _panelStatusInfo:PanelStatusInfo;

        public function ResPanelStatusInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._panelStatusInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._panelStatusInfo = readBean(PanelStatusInfo) as PanelStatusInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 148103;
        }// end function

        public function get panelStatusInfo() : PanelStatusInfo
        {
            return this._panelStatusInfo;
        }// end function

        public function set panelStatusInfo(param1:PanelStatusInfo) : void
        {
            this._panelStatusInfo = param1;
            return;
        }// end function

    }
}
