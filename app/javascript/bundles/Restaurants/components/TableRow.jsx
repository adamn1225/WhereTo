import React from 'react'

const TableRow = props => (
      <div className="venue-row text-center">
        <button 
          value={props.venue.name} 
          style={{ cursor: 'pointer' }} 
          onClick={ () =>  { props.handleClick(props.venue) } } 
          className={ props.selected ? "btn btn-outline-secondary waves-effect venues" : "btn btn-outline-danger waves-effect venues"}
        > {props.venue.name}
        </button>
      </div>
)

export default TableRow
