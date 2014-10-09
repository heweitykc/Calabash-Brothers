package com.game.challenge.view
{
    import com.cfg.vo.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.challenge.control.*;
    import com.game.challenge.event.*;
    import com.game.challenge.model.*;
    import com.game.challenge.view.component.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class BossTreasureView extends Component
    {
        private var pageNum:int = 1;
        private var pageIndex:int = 2;
        private var _currentPage:int = 0;
        private const LOCATION:Array;
        private var _bossViews:Dictionary;
        private var _stateTxts:Array;
        private var _leftBtn:BaseButton;
        private var _rightBtn:BaseButton;
        private var _bossContainerMc:MovieClip;

        public function BossTreasureView(param1:int = 2)
        {
            this.LOCATION = [{x:0, y:0}, {x:23, y:198}, {x:220, y:12}, {x:243, y:210}, {x:446, y:0}, {x:469, y:198}, {x:730, y:0}, {x:753, y:198}, {x:953, y:12}, {x:973, y:210}, {x:1176, y:0}];
            this.pageIndex = param1;
            initComponentUI("bossGuide_bossTreasure");
            this.move(14, 84);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._leftBtn = new BaseButton(getDisplayChildByName("leftBtn"));
            this._rightBtn = new BaseButton(getDisplayChildByName("rightBtn"));
            this._bossContainerMc = getDisplayChildByName("bossContainerMc");
            this.initBossBg();
            this.updatePageBtn();
            return;
        }// end function

        private function updatePageBtn() : void
        {
            if (this._currentPage == 0)
            {
                this._leftBtn.visible = false;
            }
            else
            {
                this._leftBtn.visible = true;
            }
            if (this._currentPage == (this.pageNum - 1))
            {
                this._rightBtn.visible = false;
            }
            else
            {
                this._rightBtn.visible = true;
            }
            return;
        }// end function

        private function initBossBg() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = BossGuideControl.getInstance().bossInfo.config;
            this._bossViews = new Dictionary();
            this._bossContainerMc = getDisplayChildByName("bossContainerMc");
            this._bossContainerMc.mouseEnabled = false;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_1.length)
            {
                
                if ((_loc_1[_loc_5] as QMonsterBossQcfg).q_page == this.pageIndex)
                {
                    _loc_2 = new BossItem("bossGuide_bossMc");
                    _loc_2.move(this.LOCATION[_loc_4].x, this.LOCATION[_loc_4].y);
                    _loc_2.setConfig((_loc_5 + 1), _loc_1[_loc_5]);
                    this._bossContainerMc.addChild(_loc_2);
                    this._bossViews[_loc_5] = _loc_2;
                    _loc_4++;
                }
                _loc_5++;
            }
            this.pageNum = Math.ceil(_loc_4 / 6);
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._leftBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._currentPage - 1;
                    _loc_2._currentPage = _loc_3;
                    this.updatePageBtn();
                    TweenLite.to(this._bossContainerMc, 0.5, {x:this._bossContainerMc.x + 730});
                    break;
                }
                case this._rightBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._currentPage + 1;
                    _loc_2._currentPage = _loc_3;
                    this.updatePageBtn();
                    TweenLite.to(this._bossContainerMc, 0.5, {x:this._bossContainerMc.x - 730});
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function freshInfo(event:BossGuideEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.target as BossInfo;
            for (_loc_3 in this._bossViews)
            {
                
                (_loc_5[_loc_3] as BossItem).updateInfo(_loc_2);
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            BossGuideControl.getInstance().bossInfo.addEvtListener(BossGuideEvent.UPDATEBOSS, this.freshInfo);
            BossGuideControl.getInstance().reqSelectChallengeToGame(1);
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            BossGuideControl.getInstance().bossInfo.addEvtListener(BossGuideEvent.UPDATEBOSS, this.freshInfo);
            return;
        }// end function

    }
}
