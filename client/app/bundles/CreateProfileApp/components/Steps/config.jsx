import Step1 from '../Step1/Step1';
import Step2 from '../Step2/Step2';
import Step3 from '../Step3/Step3';
import React from 'react';

export const config = [
  {
    component: Step1,
    itemTitle: '1 этап',
    title: <p>Выберите <span className="dr-header-span-unmarked">&nbsp;специализацию</span></p>
  },
  {
    component: Step2,
    itemTitle: '2 этап',
    title: <p>Заполните <span className="dr-header-span-unmarked">&nbsp;форму</span></p>
  },
  {
    component: Step3,
    itemTitle: '3 этап',
    title: <p>Заполните <span className="dr-header-span-unmarked">&nbsp;форму</span></p>
  },
];
