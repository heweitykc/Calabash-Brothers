package com.game.map.view.bar
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.casting.control.*;
    import com.game.equipstreng.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.primaryrole.control.*;
    import com.greensock.*;
    import flash.events.*;

    public class ReliveCenterBar extends Component
    {
        private var boxItem1Btn:BaseButton;
        private var boxItem2Btn:BaseButton;
        private var boxItem3Btn:BaseButton;
        private var boxItem4Btn:BaseButton;
        private var boxItem5Btn:BaseButton;
        private var boxItem6Btn:BaseButton;
        private var boxItem7Btn:BaseButton;
        private var boxItemArray:Array;
        private var currentFirstFrame:uint = 0;
        private var internelFrame:uint = 4;
        private var len:uint;
        private var lockSlide:uint = 0;
        private var params:Object;

        public function ReliveCenterBar()
        {
            super("relive.centerBar");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.boxItemArray = [];
            this.boxItem1Btn = new BaseButton(getDisplayChildByName("boxItem1Btn"));
            this.boxItem2Btn = new BaseButton(getDisplayChildByName("boxItem2Btn"));
            this.boxItem3Btn = new BaseButton(getDisplayChildByName("boxItem3Btn"));
            this.boxItem4Btn = new BaseButton(getDisplayChildByName("boxItem4Btn"));
            this.boxItemArray.push(this.boxItem1Btn);
            this.boxItemArray.push(this.boxItem2Btn);
            this.boxItemArray.push(this.boxItem3Btn);
            this.boxItemArray.push(this.boxItem4Btn);
            this.len = this.boxItemArray.length;
            return;
        }// end function

        public function lastFrame() : Boolean
        {
            var i:int;
            if (this.lockSlide != 0)
            {
                return true;
            }
            if (this.currentFirstFrame <= 0)
            {
                return false;
            }
            i;
            while (i < this.len)
            {
                
                var _loc_2:* = this;
                var _loc_3:* = this.lockSlide + 1;
                _loc_2.lockSlide = _loc_3;
                TweenLite.to(this.boxItemArray[i], 0.2, {x:this.boxItemArray[i].x + 103, onComplete:function () : void
            {
                var _loc_2:* = lockSlide - 1;
                lockSlide = _loc_2;
                return;
            }// end function
            });
                i = (i + 1);
            }
            var _loc_2:* = this;
            var _loc_3:* = this.currentFirstFrame - 1;
            _loc_2.currentFirstFrame = _loc_3;
            if (this.currentFirstFrame <= 0)
            {
                return false;
            }
            return true;
        }// end function

        public function nextFrame() : Boolean
        {
            var i:int;
            if (this.lockSlide != 0)
            {
                return true;
            }
            if (this.currentFirstFrame + this.internelFrame >= this.len)
            {
                return false;
            }
            i;
            while (i < this.len)
            {
                
                var _loc_2:* = this;
                var _loc_3:* = this.lockSlide + 1;
                _loc_2.lockSlide = _loc_3;
                TweenLite.to(this.boxItemArray[i], 0.2, {x:this.boxItemArray[i].x - 103, onComplete:function () : void
            {
                var _loc_2:* = lockSlide - 1;
                lockSlide = _loc_2;
                return;
            }// end function
            });
                i = (i + 1);
            }
            var _loc_2:* = this;
            var _loc_3:* = this.currentFirstFrame + 1;
            _loc_2.currentFirstFrame = _loc_3;
            if (this.currentFirstFrame + this.internelFrame >= this.len)
            {
                return false;
            }
            return true;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.len)
            {
                
                if (this.boxItemArray[_loc_2] == event.target)
                {
                    this.gotoAndShow(_loc_2);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function gotoAndShow(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    ZhuZaoControl.getInstance().openZhuZaoPanel();
                    break;
                }
                case 1:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(1);
                    break;
                }
                case 2:
                {
                    PrimaryRoleControl.getInstance().openHorse();
                    break;
                }
                case 3:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(2);
                    break;
                }
                case 7:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initData(param1:Object) : void
        {
            this.params = param1;
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

    }
}
