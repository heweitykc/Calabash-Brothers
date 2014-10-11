package com.game.chat.model
{
    import com.f1.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class ChatModel extends BaseEventDispatcher
    {
        private var _totalArr:LoopArray;
        private var _worldArr:LoopArray;
        private var _teamArr:LoopArray;
        private var _roleArr:LoopArray;
        private var _groupArr:LoopArray;
        private var _gmArr:LoopArray;
        private var _curArr:LoopArray;
        private var _transactionArray:LoopArray;
        private var _inTextEvent:Boolean;
        private var _preTimer:Object;
        private static var _inst:ChatModel;
        public static const LABA:int = 700048;

        public function ChatModel()
        {
            this._totalArr = new LoopArray(50);
            this._worldArr = new LoopArray(25);
            this._teamArr = new LoopArray(25);
            this._roleArr = new LoopArray(25);
            this._groupArr = new LoopArray(25);
            this._gmArr = new LoopArray(25);
            this._transactionArray = new LoopArray(50);
            this._preTimer = new Object();
            this._preTimer[ChatType.CHATTYPE_GROUP] = 0;
            this._preTimer[ChatType.CHATTYPE_HORN] = 0;
            this._preTimer[ChatType.CHATTYPE_ROLE] = 0;
            this._preTimer[ChatType.CHATTYPE_SCENE] = 0;
            this._preTimer[ChatType.CHATTYPE_TEAM] = 0;
            this._preTimer[ChatType.CHATTYPE_WORLD] = 0;
            this._preTimer[ChatType.CHATTYPE_GM] = 0;
            this._preTimer[ChatType.CHATTYPE_HORN] = 0;
            this._curArr = this._totalArr;
            return;
        }// end function

        public function get transactionArray() : LoopArray
        {
            return this._transactionArray;
        }// end function

        public function set transactionArray(param1:LoopArray) : void
        {
            this._transactionArray = param1;
            return;
        }// end function

        public function get inTextEvent() : Boolean
        {
            return this._inTextEvent;
        }// end function

        public function set inTextEvent(param1:Boolean) : void
        {
            this._inTextEvent = param1;
            return;
        }// end function

        public function get preTimer() : Object
        {
            return this._preTimer;
        }// end function

        public function set preTimer(param1:Object) : void
        {
            this._preTimer = param1;
            return;
        }// end function

        public function get curArr() : LoopArray
        {
            return this._curArr;
        }// end function

        public function set curArr(param1:LoopArray) : void
        {
            this._curArr = param1;
            return;
        }// end function

        public function get totalArr() : LoopArray
        {
            return this._totalArr;
        }// end function

        public function set totalArr(param1:LoopArray) : void
        {
            this._totalArr = param1;
            return;
        }// end function

        public function get worldArr() : LoopArray
        {
            return this._worldArr;
        }// end function

        public function set worldArr(param1:LoopArray) : void
        {
            this._worldArr = param1;
            return;
        }// end function

        public function get roleArr() : LoopArray
        {
            return this._roleArr;
        }// end function

        public function set roleArr(param1:LoopArray) : void
        {
            this._roleArr = param1;
            return;
        }// end function

        public function get teamArr() : LoopArray
        {
            return this._teamArr;
        }// end function

        public function set teamArr(param1:LoopArray) : void
        {
            this._teamArr = param1;
            return;
        }// end function

        public function get groupArr() : LoopArray
        {
            return this._groupArr;
        }// end function

        public function set groupArr(param1:LoopArray) : void
        {
            this._groupArr = param1;
            return;
        }// end function

        public function addToCue(param1:ChatInfo) : void
        {
            switch(param1.chattype)
            {
                case ChatType.CHATTYPE_GM:
                {
                    break;
                }
                case ChatType.CHATTYPE_GROUP:
                {
                    this._groupArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_ROLE:
                {
                    this._roleArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_TEAM:
                {
                    this._teamArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_WORLD:
                {
                    this._worldArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_SYSTEM:
                {
                    this._totalArr.push(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function accept(param1:ChatInfo) : void
        {
            this._totalArr.push(param1);
            switch(param1.chattype)
            {
                case ChatType.CHATTYPE_WORLD:
                {
                    this.worldArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_TEAM:
                {
                    this.teamArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_ROLE:
                {
                    this.roleArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_GROUP:
                {
                    this.groupArr.push(param1);
                    break;
                }
                case ChatType.CHATTYPE_TRANSACTION:
                {
                    this._transactionArray.push(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : ChatModel
        {
            var _loc_1:* = new ChatModel;
            _inst = new ChatModel;
            return _inst || _loc_1;
        }// end function

        public static function getInteralTime(param1:int) : int
        {
            switch(param1)
            {
                case ChatType.CHATTYPE_SCENE:
                case ChatType.CHATTYPE_ROLE:
                case ChatType.CHATTYPE_TEAM:
                case ChatType.CHATTYPE_GROUP:
                {
                    return 3000;
                }
                case ChatType.CHATTYPE_WORLD:
                {
                    return 7000;
                }
                case ChatType.CHATTYPE_HORN:
                {
                    return 10000;
                }
                default:
                {
                    return 0;
                    break;
                }
            }
        }// end function

    }
}
