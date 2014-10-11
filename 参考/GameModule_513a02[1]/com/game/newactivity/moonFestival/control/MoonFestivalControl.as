package com.game.newactivity.moonFestival.control
{
    import com.*;
    import com.f1.*;
    import com.game.bocake.message.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.moonFestival.model.*;
    import com.game.newactivity.moonFestival.protocol.*;
    import com.game.newactivity.moonFestival.view.*;
    import com.staticdata.*;

    public class MoonFestivalControl extends Object
    {
        private var _panel:MoonFestivalPanel;
        private var _diceProtocol:MoonDiceProtocol;
        private static var instance:MoonFestivalControl;

        public function MoonFestivalControl()
        {
            this._diceProtocol = new MoonDiceProtocol();
            return;
        }// end function

        public function openOrClose(param1:int = 1) : void
        {
            if (NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_MOONFESTIVAL_ACT) == null)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10962"));
                return;
            }
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.openOrClose();
            this._panel.curSelIndex = param1;
            return;
        }// end function

        public function close() : void
        {
            if (this._panel)
            {
                this._panel.close();
            }
            return;
        }// end function

        public function createDiceRankTips() : void
        {
            if (this._panel)
            {
                this._panel.createDiceRankTips();
            }
            return;
        }// end function

        private function initPanel() : void
        {
            this._panel = new MoonFestivalPanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public function resOpenPainBack(param1:ResOpenPainMessage) : void
        {
            if (this._panel)
            {
                this._panel.setPainInfo(param1.count, param1.list);
            }
            return;
        }// end function

        public function doDiceResult(param1:ResOpenBoCakeInfoToClientMessage) : void
        {
            var _loc_2:* = MoonDiceModel.getInstance();
            _loc_2.changetimes = param1.changeCount;
            _loc_2.firstItems = param1.reward1;
            _loc_2.secondItems = param1.reward2;
            _loc_2.thirdItems = param1.reward3;
            _loc_2.lasttimes = param1.count;
            _loc_2.rankScroe = param1.rank;
            _loc_2.scroe = param1.fraction;
            _loc_2.records = param1.boCakeRankInfoList;
            _loc_2.addFraction = param1.addFraction;
            _loc_2.itemCount = param1.itemCount;
            _loc_2.opertype = param1.type;
            this.createDiceRankTips();
            if (this._panel && this._panel.isOpen)
            {
                this._panel.doDiceResult(param1.redFour);
                this._panel.showDiceInfo();
            }
            else
            {
                _loc_2.lastResult = param1.redFour;
            }
            return;
        }// end function

        public function openDiceReq() : void
        {
            this._diceProtocol.reqOpenDice();
            return;
        }// end function

        public function diceReq(param1:int) : void
        {
            this._diceProtocol.reqDice(param1);
            return;
        }// end function

        public static function getInstance() : MoonFestivalControl
        {
            if (instance == null)
            {
                instance = new MoonFestivalControl;
            }
            return instance;
        }// end function

    }
}
