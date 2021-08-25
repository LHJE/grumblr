import React from 'react';
import ReactDOM from 'react-dom';
import faker from 'faker';
import CommentDetail from './CommentDetail';

const App = () => {
  return (
    <div className="ui container comments">
      <CommentDetail
        author="Sam"
        timeAgo="Today at 6:00PM"
        content="It's a post!"
        image={faker.image.avatar()} />
      <CommentDetail
        author="Alex"
        timeAgo="Today at 2:00AM"
        content="It's another post!"
        image={faker.image.avatar()} />
      <CommentDetail
        author="Jane"
        timeAgo="Yesterday at 5:00PM"
        content="It's a third post!"
        image={faker.image.avatar()} />
    </div>
  );
};

ReactDOM.render(
  <App />,
  document.querySelector('#root')
);
