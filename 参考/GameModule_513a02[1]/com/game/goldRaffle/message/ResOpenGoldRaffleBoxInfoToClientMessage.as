package com.game.goldRaffle.message
{
    import com.game.goldRaffle.bean.*;
    import net.*;

    public class ResOpenGoldRaffleBoxInfoToClientMessage extends Message
    {
        private var _goldRaffleBoxInfo:GoldRaffleBoxInfo;

        public function ResOpenGoldRaffleBoxInfoToClientMessage()
        {
            return;
        }// end function

        public function set goldRaffleBoxInfo(param1:GoldRaffleBoxInfo) : void
        {
            this._goldRaffleBoxInfo = param1;
            return;
        }// end function

        public function get goldRaffleBoxInfo() : GoldRaffleBoxInfo
        {
            return this._goldRaffleBoxInfo;
        }// end function

        override public function getId() : int
        {
            return 528104;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._goldRaffleBoxInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goldRaffleBoxInfo = readBean(GoldRaffleBoxInfo) as GoldRaffleBoxInfo;
            return true;
        }// end function

    }
}
