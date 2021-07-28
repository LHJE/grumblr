import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import Grumbls from "../components/Grumbls";
import Grumbl from "../components/Grumbl";
import NewGrumbl from "../components/NewGrumbl";
import Dashboard from '../components/Dashboard';
import Preferences from '../components/Preferences';
import Login from '../components/Login';


export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/grumbls" exact component={Grumbls} />
      <Route path="/grumbl/:id" exact component={Grumbl} />
      <Route path="/grumbl" exact component={NewGrumbl} />
      <Route path="/dashboard" exact component={Dashboard} />
      <Route path="/preferences" exact component={Preferences} />
    </Switch>
  </Router>
);
