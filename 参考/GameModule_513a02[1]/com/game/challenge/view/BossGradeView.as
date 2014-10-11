package com.game.challenge.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class BossGradeView extends Component
    {
        private var _list:List;

        public function BossGradeView()
        {
            initComponentUI("bossGuide_bossGrade");
            this.move(14, 84);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._list = new List(770, 450);
            this._list.move(0, 0);
            this._list.intervalY = -3;
            this._list.cellRenderer = BossGuildeGradeItem;
            addChild(this._list);
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this._list.objs = QMonsterBossQcfgObj.getInstance().getMonsterBossListPage1();
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            return;
        }// end function

    }
}
