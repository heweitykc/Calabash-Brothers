package com.game.greedisland.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.greedisland.model.*;
    import com.game.prompt.utils.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class IslandOverPanel extends BaseBox
    {
        private const HIT_OPEN_CARDS:String;
        private var _btnClose:BaseButton;
        private var _btnLeave:BaseButton;
        private var box1:BaseButton;
        private var box2:BaseButton;
        private var box3:BaseButton;
        private var box4:BaseButton;
        private var _tileSuccess:MovieClip;
        private var _backBlackUp:Shape;
        private var islandbox1:MovieClip;
        private var islandbox2:MovieClip;
        private var islandbox3:MovieClip;
        private var islandbox4:MovieClip;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc_effect1:MovieClip;
        private var mc_effect2:MovieClip;
        private var mc_effect3:MovieClip;
        private var mc_effect4:MovieClip;
        private var mcArray:Array;
        private var _back:MovieClip;
        private var _electments1:Vector.<Object>;
        private var _electments2:Vector.<Object>;
        private var _electments3:Vector.<Object>;
        private var _electments4:Vector.<Object>;
        private var _effect:VMCView;

        public function IslandOverPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.HIT_OPEN_CARDS = LanguageCfgObj.getInstance().getByIndex("11488");
            this.mcArray = [];
            _peaceBox = ["*"];
            loadDisplay("res/islandover.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("islandOverBox", 0);
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        private function initUI() : void
        {
            this._backBlackUp = new Shape();
            this.addChild(this._backBlackUp);
            this.setChildIndex(this._backBlackUp, 0);
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnClose.visible = false;
            this._btnLeave = new BaseButton(getDisplayChildByName("btn_leave"));
            this.box1 = new BaseButton(getDisplayChildByName("box1"));
            this.box2 = new BaseButton(getDisplayChildByName("box2"));
            this.box3 = new BaseButton(getDisplayChildByName("box3"));
            this.box4 = new BaseButton(getDisplayChildByName("box4"));
            var _loc_1:* = false;
            this.box4.visible = false;
            this.box3.visible = _loc_1;
            this.box2.visible = _loc_1;
            this.box1.visible = _loc_1;
            this._tileSuccess = MovieClip(getDisplayChildByName("tile_success"));
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            this.mc5 = getDisplayChildByName("mc5");
            this.mcArray.push(this.mc3, this.mc2, this.mc4, this.mc1, this.mc5);
            var _loc_1:* = false;
            this.mc5.visible = false;
            this.mc4.visible = _loc_1;
            this.mc3.visible = _loc_1;
            this.mc2.visible = _loc_1;
            this.mc1.visible = _loc_1;
            this.mc_effect1 = getDisplayChildByName("mc_effect1");
            this.mc_effect2 = getDisplayChildByName("mc_effect2");
            this.mc_effect3 = getDisplayChildByName("mc_effect3");
            this.mc_effect4 = getDisplayChildByName("mc_effect4");
            this._back = MovieClip(getDisplayChildByName("back"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnLeave:
                {
                    this.clickLeave();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.stage.addEventListener(Event.RESIZE, this.onResize);
            this.setBackMask();
            this.updatePanel();
            TweenLite.delayedCall(1, this.startEffect);
            TweenLite.delayedCall(60, this.callClose);
            return;
        }// end function

        private function callClose() : void
        {
            this._btnLeave.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.stage.removeEventListener(Event.RESIZE, this.onResize);
            TweenLite.killDelayedCallsTo(this.callClose);
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            this.setBackMask();
            return;
        }// end function

        private function setBackMask() : void
        {
            var _loc_1:* = FrameworkGlobal.stageW;
            var _loc_2:* = FrameworkGlobal.stageH;
            var _loc_3:* = 1600;
            var _loc_4:* = 578;
            this._backBlackUp.x = (-(_loc_1 - _loc_3)) / 2;
            this._backBlackUp.y = (-(_loc_2 - _loc_4)) / 2;
            this._backBlackUp.graphics.clear();
            this._backBlackUp.graphics.beginFill(0, 0.5);
            this._backBlackUp.graphics.drawRect(0, 0, _loc_1, _loc_2);
            this._backBlackUp.graphics.endFill();
            return;
        }// end function

        private function clickLeave() : void
        {
            this.leaveInstance();
            return;
        }// end function

        private function leaveInstance() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        private function updatePanel() : void
        {
            if (this.islandbox1)
            {
                removeChild(this.islandbox1);
                removeChild(this.islandbox2);
                removeChild(this.islandbox3);
                removeChild(this.islandbox4);
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.mcArray.length)
            {
                
                if (this.mcArray[_loc_1])
                {
                    ToolKit.clearMcChild(this.mcArray[_loc_1]);
                }
                _loc_1++;
            }
            return;
        }// end function

        private function startEffect() : void
        {
            var point1:Point;
            var point2:Point;
            var point3:Point;
            var _electments5:Vector.<Object>;
            var count1:int;
            var count2:int;
            var count3:int;
            var count4:int;
            var kind:int;
            var count5:int;
            var count6:int;
            var j:int;
            var item:IconItem;
            var prop:PropInfo;
            this._tileSuccess.gotoAndPlay(1);
            this.islandbox1 = ToolKit.getNew("islandbox1");
            this.islandbox2 = ToolKit.getNew("islandbox2");
            this.islandbox3 = ToolKit.getNew("islandbox3");
            this.islandbox4 = ToolKit.getNew("islandbox4");
            this.islandbox1.gotoAndStop(1);
            this.islandbox2.gotoAndStop(1);
            this.islandbox3.gotoAndStop(1);
            this.islandbox4.gotoAndStop(1);
            var temp:* = ZonesControl.getInstance().islandTrace.box1point;
            point1 = globalToLocal(ZonesControl.getInstance().islandTrace.box1point);
            point2 = globalToLocal(ZonesControl.getInstance().islandTrace.box2point);
            point3 = globalToLocal(ZonesControl.getInstance().islandTrace.box3point);
            var point4:* = globalToLocal(ZonesControl.getInstance().islandTrace.box4point);
            this.islandbox1.x = point1.x;
            this.islandbox1.y = point1.y;
            this.islandbox2.x = point2.x;
            this.islandbox2.y = point2.y;
            this.islandbox3.x = point3.x;
            this.islandbox3.y = point3.y;
            this.islandbox4.x = point4.x;
            this.islandbox4.y = point4.y;
            this.addChild(this.islandbox1);
            this.addChild(this.islandbox2);
            this.addChild(this.islandbox3);
            this.addChild(this.islandbox4);
            TweenLite.to(this.islandbox1, 2, {x:this.box1.x, y:this.box1.y});
            TweenLite.to(this.islandbox2, 2, {x:this.box2.x, y:this.box2.y});
            TweenLite.to(this.islandbox3, 2, {x:this.box3.x, y:this.box3.y});
            TweenLite.to(this.islandbox4, 2, {x:this.box4.x, y:this.box4.y});
            addChild(this.mc_effect1);
            addChild(this.mc_effect2);
            addChild(this.mc_effect3);
            addChild(this.mc_effect4);
            TweenLite.delayedCall(2.1, function () : void
            {
                playEffect(1);
                islandbox1.gotoAndStop(2);
                return;
            }// end function
            );
            TweenLite.delayedCall(2.6, function () : void
            {
                playEffect(2);
                islandbox2.gotoAndStop(2);
                return;
            }// end function
            );
            TweenLite.delayedCall(3.1, function () : void
            {
                playEffect(3);
                islandbox3.gotoAndStop(2);
                return;
            }// end function
            );
            TweenLite.delayedCall(3.6, function () : void
            {
                playEffect(4);
                islandbox4.gotoAndStop(2);
                return;
            }// end function
            );
            this._electments1 = IslandData.getInstance().electments1.slice();
            this._electments2 = IslandData.getInstance().electments2.slice();
            this._electments3 = IslandData.getInstance().electments3.slice();
            this._electments4 = IslandData.getInstance().electments4.slice();
            this._electments1.sort(this.compare);
            this._electments2.sort(this.compare);
            this._electments3.sort(this.compare);
            this._electments4.sort(this.compare);
            _electments5 = new Vector.<Object>;
            _electments5 = _electments5.concat(this._electments1.splice(0, 5));
            _electments5 = _electments5.concat(this._electments2.splice(0, 5));
            _electments5 = _electments5.concat(this._electments3.splice(0, 5));
            _electments5 = _electments5.concat(this._electments4.splice(0, 5));
            _electments5.sort(this.compare);
            var k:int;
            while (k < _electments5.length)
            {
                
                kind = _electments5[k].kind;
                this["_electments" + kind].unshift(_electments5[k]);
                k = (k + 1);
            }
            _electments5 = _electments5.splice(0, 5);
            var count:int;
            count1;
            var i:int;
            while (i < this._electments4.length)
            {
                
                TweenLite.delayedCall(3.6 + count * 0.1, function () : void
            {
                ItemGetAnim.doFlyToBackPack(_electments4[count1].modelId, localToGlobal(new Point(box4.x, box4.y)));
                var _loc_2:* = count1 + 1;
                count1 = _loc_2;
                return;
            }// end function
            );
                count = (count + 1);
                i = (i + 1);
            }
            count;
            count2;
            i;
            while (i < this._electments3.length)
            {
                
                TweenLite.delayedCall(4.1 + count * 0.1, function () : void
            {
                ItemGetAnim.doFlyToBackPack(_electments3[count2].modelId, localToGlobal(new Point(box3.x, box3.y)));
                var _loc_2:* = count2 + 1;
                count2 = _loc_2;
                return;
            }// end function
            );
                count = (count + 1);
                i = (i + 1);
            }
            count;
            count3;
            i;
            while (i < this._electments2.length)
            {
                
                TweenLite.delayedCall(4.6 + count * 0.1, function () : void
            {
                ItemGetAnim.doFlyToBackPack(_electments2[count3].modelId, localToGlobal(new Point(box2.x, box2.y)));
                var _loc_2:* = count3 + 1;
                count3 = _loc_2;
                return;
            }// end function
            );
                count = (count + 1);
                i = (i + 1);
            }
            count;
            count4;
            i;
            while (i < this._electments1.length)
            {
                
                TweenLite.delayedCall(5.1 + count * 0.1, function () : void
            {
                ItemGetAnim.doFlyToBackPack(_electments1[count4].modelId, localToGlobal(new Point(box1.x, box1.y)));
                var _loc_2:* = count4 + 1;
                count4 = _loc_2;
                return;
            }// end function
            );
                count = (count + 1);
                i = (i + 1);
            }
            count;
            if (_electments5.length)
            {
                count5;
                count6;
                j;
                while (j < 5 && j < _electments5.length)
                {
                    
                    item = new IconItem("commonRewardBox2_40");
                    prop = PropUtil.createItemByCfg(_electments5[j].modelId);
                    item.image.move(4, 3);
                    item.setWH(46, 46);
                    item.setInfo(prop);
                    item.count = _electments5[j].num;
                    ToolKit.clearMcChild(this.mcArray[j]);
                    this.mcArray[j].addChild(item);
                    this.mcArray[j].visible = false;
                    TweenLite.delayedCall(5.1 + count * 0.1, function () : void
            {
                var box:BaseButton;
                var kind:* = _electments5[count5].kind;
                switch(kind)
                {
                    case 1:
                    {
                        box = box1;
                        break;
                    }
                    case 2:
                    {
                        box = box2;
                        break;
                    }
                    case 3:
                    {
                        box = box3;
                        break;
                    }
                    case 4:
                    {
                        box = box4;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                ItemGetAnim.doFlyIcon(_electments5[count5].modelId, localToGlobal(new Point(box.x, box.y)), localToGlobal(new Point(mcArray[count5].x - 10, mcArray[count5].y - 10)), 2);
                TweenLite.delayedCall(2, function () : void
                {
                    mcArray[count6].visible = true;
                    var _loc_2:* = count6 + 1;
                    count6 = _loc_2;
                    return;
                }// end function
                );
                var _loc_3:* = count5 + 1;
                count5 = _loc_3;
                return;
            }// end function
            );
                    count = (count + 1);
                    j = (j + 1);
                }
            }
            return;
        }// end function

        private function compare(param1:Object, param2:Object) : int
        {
            if (param1.q_swallow < param2.q_swallow)
            {
                return 1;
            }
            if (param1.q_swallow > param2.q_swallow)
            {
                return -1;
            }
            return 0;
        }// end function

        private function playEffect(param1:int) : void
        {
            if (this._effect == null)
            {
                this._effect = new VMCView();
            }
            this._effect.auto = true;
            this._effect.loadRes("res/effect/zones/openbox.png");
            this._effect.updatePose("90", false, false, true, true);
            this._effect.replay();
            if (this["mc_effect" + param1])
            {
                this["mc_effect" + param1].addChild(this._effect);
            }
            return;
        }// end function

    }
}
