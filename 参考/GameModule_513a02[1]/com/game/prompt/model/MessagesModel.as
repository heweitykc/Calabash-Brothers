package com.game.prompt.model
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.utils.*;
    import com.game.chat.model.*;
    import com.game.clickstream.*;
    import com.game.prompt.utils.*;
    import com.model.vo.*;

    public class MessagesModel extends Object
    {
        private var _util:PromptUtil;
        private var _normalArr:LoopArray;
        private var _importantArr:LoopArray;
        private var _zhuzaoArr:LoopArray;
        private var _transactionArr:LoopArray;
        public static const NORMAL:int = 0;
        public static const IMOPROTANT:int = 1;
        public static const ZHUZAO:int = 2;
        public static const TRANSACTION:int = 3;
        private static var _inst:MessagesModel;

        public function MessagesModel()
        {
            this._normalArr = new LoopArray(100);
            this._importantArr = new LoopArray(100);
            this._zhuzaoArr = new LoopArray(100);
            this._transactionArr = new LoopArray(100);
            this._util = new PromptUtil();
            if (BasicGlobal.jinhui.clickStream)
            {
                ClickStream.setMsgCallback(function (param1:String) : void
            {
                addMessage(1, param1);
                return;
            }// end function
            );
                ClickStream.setMsgCallback(BasicGlobal.popManager.addedToMouseCue);
            }
            return;
        }// end function

        public function addMessage(param1:int, param2:String, param3:Vector.<String> = null, param4:Vector.<GoodsInfoRes> = null) : void
        {
            var _loc_6:* = null;
            var _loc_5:* = this.getMessageArr(param1);
            if (this.getMessageArr(param1))
            {
                _loc_6 = this._util.transMsgToObject(param2, param3, param4);
                _loc_6.time = ToolKit.getServerTime() * 0.001;
                _loc_5.shift(_loc_6);
            }
            return;
        }// end function

        public function getMessageArr(param1:int) : LoopArray
        {
            switch(param1)
            {
                case NORMAL:
                {
                    return this._normalArr;
                }
                case IMOPROTANT:
                {
                    return this._importantArr;
                }
                case ZHUZAO:
                {
                    return this._zhuzaoArr;
                }
                case TRANSACTION:
                {
                    return this._transactionArr;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public static function getInstance() : MessagesModel
        {
            var _loc_1:* = new MessagesModel;
            _inst = new MessagesModel;
            return _inst || _loc_1;
        }// end function

    }
}
