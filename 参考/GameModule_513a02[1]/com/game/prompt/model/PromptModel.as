package com.game.prompt.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.manager.*;

    public class PromptModel extends BaseModule
    {
        private var _vecTable:Vector.<PromptVo>;
        private static var _instance:PromptModel;

        public function PromptModel()
        {
            this._vecTable = new Vector.<PromptVo>;
            this.initData();
            return;
        }// end function

        private function initData() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = CfgManager.getInstance().getMap("systemmessage");
            _loc_2 = _loc_1;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new PromptVo(_loc_2);
                this._vecTable.push(_loc_3);
            }
            return;
        }// end function

        public function getItemFromMark(param1:String) : PromptVo
        {
            var _loc_3:* = null;
            var _loc_2:* = this._vecTable.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this._vecTable[_loc_4];
                if (_loc_3.mark == param1)
                {
                    return _loc_3;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public static function getInstance() : PromptModel
        {
            if (!_instance)
            {
                _instance = new PromptModel;
            }
            return _instance;
        }// end function

    }
}
