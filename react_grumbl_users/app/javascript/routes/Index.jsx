import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
// import {BrowserRouter, Switch, Route} from 'react-router-dom';
import Home from "../components/Home";
import Grumbls from "../components/Grumbls";
import Grumbl from "../components/Grumbl";
import NewGrumbl from "../components/NewGrumbl";
import axios from 'axios'

class Index extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoggedIn: false,
      user: {}
     };
  };

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/grumbls" exact component={Grumbls} />
      <Route path="/grumbl/:id" exact component={Grumbl} />
      <Route path="/grumbl" exact component={NewGrumbl} />
      <Route exact path='/login' component={}/>
      <Route exact path='/signup' component={}/>
    </Switch>
  </Router>
);
