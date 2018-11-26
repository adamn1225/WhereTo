import React from 'react'
import TableRow from './TableRow'

const Table = props => (
  <div style={{minHeight: 400}}>
        { 
          props.restaurants.map((venue, index) => {
          return <TableRow key={index} 
                           venue={venue} 
                           selected={props.selectedRestaurant.includes(venue)}
                           handleClick={props.handleClick}/>             
          })
        }
  </div>
)

export default Table
