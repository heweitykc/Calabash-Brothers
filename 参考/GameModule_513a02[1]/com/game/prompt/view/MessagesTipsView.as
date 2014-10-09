package com.game.prompt.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.prompt.control.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class MessagesTipsView extends Component
    {
        private const MAX_LINE:int = 4;
        private var _addBtn:BaseButton;
        private var _container:Sprite;
        private var _contentArr:Array;
        private var _messagesPanel:MessagesPanel;
        private var _loseArr:Array;
        private var _back:Bitmap;
        private const outAlpha:Number = 0.2;
        private var line:int;
        private var msgItem:MessagesTipsItem;
        private var _msgsArr:Array;
        private var _inPhase:Boolean;
        private var _delayTime:int;
        private static var count:int;

        public function MessagesTipsView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            setWH(192, 102);
            this.initUI();
            var _loc_4:* = count + 1;
            count = _loc_4;
            if (count > 1)
            {
                throw new Error("第二个");
            }
            this.addlistener();
            this.setOut();
            return;
        }// end function

        public function openMessagesPanel() : void
        {
            if (this._messagesPanel == null)
            {
                this._messagesPanel = new MessagesPanel();
                Global.popManager.addPop(this._messagesPanel, true);
            }
            this._messagesPanel.openOrClose();
            return;
        }// end function

        private function initUI() : void
        {
            this._back = ToolKit.getNewDO("messagestipviewbg") as Bitmap;
            addChild(this._back);
            this._container = new Sprite();
            this._container.x = 14;
            this._container.y = 80;
            addChild(this._container);
            this._addBtn = new BaseButton(ToolKit.getNew("add_btn"));
            addChild(this._addBtn);
            this._addBtn.move(162, 66);
            this._contentArr = [];
            this._msgsArr = [];
            return;
        }// end function

        private function addlistener() : void
        {
            this._addBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            PromptControl.getInstance().openMessagesPanel();
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this.setOver();
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            this.setOut();
            return;
        }// end function

        public function acceptInfo(param1:String) : void
        {
            var _loc_2:* = ObjectPool.CheckOut(MessagesTipsItem);
            _loc_2.lineWidth = 164;
            _loc_2.htmlText = param1;
            _loc_2.height = _loc_2.textHeight + 4;
            this._msgsArr.push(_loc_2);
            if (!this._inPhase)
            {
                this._inPhase = true;
                this.start();
            }
            return;
        }// end function

        private function start() : void
        {
            this.msgItem = this._msgsArr.shift();
            if (this.msgItem)
            {
                this.line = this.msgItem.numLines;
                this._loseArr = this.getLoseArr(this.line);
                clearTimeout(this._delayTime);
                this._delayTime = setTimeout(this.resetPhase, 1000);
                if (this._loseArr.length == 0)
                {
                    this.moveUp(this.line);
                    this.showTips();
                }
                else
                {
                    this.disappear();
                }
            }
            else
            {
                this._inPhase = false;
            }
            return;
        }// end function

        private function disappear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._loseArr.length)
            {
                
                TweenLite.killTweensOf(this._loseArr[_loc_1]);
                TweenLite.to(this._loseArr[_loc_1], 0.3, {onComplete:this.onComplete, onCompleteParams:[this._loseArr[_loc_1]]});
                _loc_1++;
            }
            return;
        }// end function

        private function resetPhase() : void
        {
            this._inPhase = false;
            return;
        }// end function

        private function onComplete(param1:MessagesTipsItem) : void
        {
            if (param1 && param1.parent)
            {
                this._container.removeChild(param1);
            }
            this._loseArr.splice(this._loseArr.indexOf(param1), 1);
            if (this._loseArr.length == 0)
            {
                clearTimeout(this._delayTime);
                this._delayTime = setTimeout(this.resetPhase, 1000);
                this.moveUp(this.line);
                this.showTips();
            }
            return;
        }// end function

        private function getLoseArr(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this.MAX_LINE - param1;
            var _loc_4:* = 0;
            var _loc_5:* = this._contentArr.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_4 = _loc_4 + (this._contentArr[_loc_5] as MessagesTipsItem).numLines;
                if (_loc_4 >= _loc_3)
                {
                    _loc_5 = _loc_5 - 1;
                    break;
                }
                _loc_5 = _loc_5 - 1;
            }
            while (_loc_5 >= 0)
            {
                
                _loc_2.push(this._contentArr.shift());
                _loc_5 = _loc_5 - 1;
            }
            return _loc_2;
        }// end function

        private function moveUp(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._contentArr.length)
            {
                
                TweenLite.to(this._contentArr[_loc_2], 0.1, {y:this._contentArr[_loc_2].y - param1 * 18});
                _loc_2++;
            }
            return;
        }// end function

        private function showTips() : void
        {
            if (this.msgItem)
            {
                this.msgItem.y = 0;
                this._container.addChild(this.msgItem);
                this._contentArr.push(this.msgItem);
                TweenLite.delayedCall(10, this.removeMsgItem, [this.msgItem]);
                TweenLite.to(this.msgItem, 0.1, {y:-this.msgItem.height, onComplete:this.showComplete});
            }
            return;
        }// end function

        private function removeMsgItem(param1:MessagesTipsItem) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            this._loseArr.splice(this._loseArr.indexOf(param1), 1);
            return;
        }// end function

        private function showComplete() : void
        {
            this.start();
            return;
        }// end function

        private function setOver() : void
        {
            this._back.alpha = 1;
            return;
        }// end function

        private function setOut() : void
        {
            this._back.alpha = this.outAlpha;
            return;
        }// end function

    }
}
