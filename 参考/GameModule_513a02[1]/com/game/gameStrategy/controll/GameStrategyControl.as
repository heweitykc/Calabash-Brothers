package com.game.gameStrategy.controll
{
    import com.*;
    import com.game.clickstream.*;
    import com.game.gameStrategy.view.*;

    public class GameStrategyControl extends Object
    {
        private var _gameStrategyBox:GameStrategyBox;
        private static var _instance:GameStrategyControl;

        public function GameStrategyControl()
        {
            return;
        }// end function

        private function get gameStrategyBox() : GameStrategyBox
        {
            if (!this._gameStrategyBox)
            {
                this._gameStrategyBox = new GameStrategyBox();
            }
            Global.popManager.addPop(this._gameStrategyBox);
            return this._gameStrategyBox;
        }// end function

        public function openOrCloseStrategyBox() : void
        {
            if (!this.gameStrategyBox.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_YouXiJianJie);
            }
            this.gameStrategyBox.openOrClose();
            return;
        }// end function

        public static function getInstance() : GameStrategyControl
        {
            if (!_instance)
            {
                _instance = new GameStrategyControl;
            }
            return _instance;
        }// end function

    }
}
